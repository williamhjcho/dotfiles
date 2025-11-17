#!/bin/bash

function uuid() {
    uuidgen
}

function cpf() {
    # Check for validate mode
    if [[ "$1" == "--validate" ]]; then
        local input="$2"
        if [[ -z "$input" ]]; then
            echo "Error: --validate requires a CPF value" >&2
            return 1
        fi

        # Strip formatting (dots, dashes)
        local clean_cpf="${input//[.-]/}"

        # Check if it has exactly 11 digits
        if [[ ! "$clean_cpf" =~ ^[0-9]{11}$ ]]; then
            return 1
        fi

        # Extract the digits and check digits
        local digits="${clean_cpf:0:9}"
        local provided_digit1="${clean_cpf:9:1}"
        local provided_digit2="${clean_cpf:10:1}"

        # Calculate first check digit
        local sum=0
        for i in {0..8}; do
            sum=$((sum + ${digits:$i:1} * (10 - i)))
        done
        local remainder=$((sum % 11))
        local calculated_digit1=$((remainder < 2 ? 0 : 11 - remainder))

        # Calculate second check digit
        sum=0
        for i in {0..8}; do
            sum=$((sum + ${digits:$i:1} * (11 - i)))
        done
        sum=$((sum + calculated_digit1 * 2))
        remainder=$((sum % 11))
        local calculated_digit2=$((remainder < 2 ? 0 : 11 - remainder))

        # Compare check digits
        if [[ "$provided_digit1" -eq "$calculated_digit1" && "$provided_digit2" -eq "$calculated_digit2" ]]; then
            return 0
        else
            return 1
        fi
    fi

    # Generation mode
    local formatted=false
    if [[ "$1" == "--formatted" ]]; then
        formatted=true
    fi

    # Generate 9 random digits
    local digits=""
    for i in {1..9}; do
        digits+=$(shuf -i 0-9 -n 1)
    done

    # Calculate first check digit
    local sum=0
    for i in {0..8}; do
        sum=$((sum + ${digits:$i:1} * (10 - i)))
    done
    local remainder=$((sum % 11))
    local digit1=$((remainder < 2 ? 0 : 11 - remainder))

    # Calculate second check digit
    sum=0
    for i in {0..8}; do
        sum=$((sum + ${digits:$i:1} * (11 - i)))
    done
    sum=$((sum + digit1 * 2))
    remainder=$((sum % 11))
    local digit2=$((remainder < 2 ? 0 : 11 - remainder))

    if [[ "$formatted" == true ]]; then
        # local cpf_result="${digits}${digit1}${digit2}"
        echo "${digits:0:3}.${digits:3:3}.${digits:6:3}-${digit1}${digit2}"
    else
        echo "${digits}${digit1}${digit2}"
    fi
}

function cnpj() {
    # Check for validate mode
    if [[ "$1" == "--validate" ]]; then
        local input="$2"
        if [[ -z "$input" ]]; then
            echo "Error: --validate requires a CNPJ value" >&2
            return 1
        fi

        # Strip formatting (dots, dashes, slashes)
        local clean_cnpj="${input//[.\/\-]/}"

        # Check if it has exactly 14 digits
        if [[ ! "$clean_cnpj" =~ ^[0-9]{14}$ ]]; then
            return 1
        fi

        # Extract the digits and check digits
        local digits="${clean_cnpj:0:12}"
        local provided_digit1="${clean_cnpj:12:1}"
        local provided_digit2="${clean_cnpj:13:1}"

        # Calculate first check digit
        local weights=(5 4 3 2 9 8 7 6 5 4 3 2)
        local sum=0
        for i in {0..11}; do
            sum=$((sum + ${digits:$i:1} * ${weights[$i]}))
        done
        local remainder=$((sum % 11))
        local calculated_digit1=$((remainder < 2 ? 0 : 11 - remainder))

        # Calculate second check digit
        weights=(6 5 4 3 2 9 8 7 6 5 4 3 2)
        sum=0
        for i in {0..11}; do
            sum=$((sum + ${digits:$i:1} * ${weights[$i]}))
        done
        sum=$((sum + calculated_digit1 * ${weights[12]}))
        remainder=$((sum % 11))
        local calculated_digit2=$((remainder < 2 ? 0 : 11 - remainder))

        # Compare check digits
        if [[ "$provided_digit1" -eq "$calculated_digit1" && "$provided_digit2" -eq "$calculated_digit2" ]]; then
            return 0
        else
            return 1
        fi
    fi

    # Generation mode
    local formatted=false
    if [[ "$1" == "--formatted" ]]; then
        formatted=true
    fi

    # Generate 12 random digits (8 for base + 4 for branch/sequence)
    local digits=""
    for i in {1..12}; do
        digits+=$(shuf -i 0-9 -n 1)
    done

    # Calculate first check digit
    local weights=(5 4 3 2 9 8 7 6 5 4 3 2)
    local sum=0
    for i in {0..11}; do
        sum=$((sum + ${digits:$i:1} * ${weights[$i]}))
    done
    local remainder=$((sum % 11))
    local digit1=$((remainder < 2 ? 0 : 11 - remainder))

    # Calculate second check digit
    weights=(6 5 4 3 2 9 8 7 6 5 4 3 2)
    sum=0
    for i in {0..11}; do
        sum=$((sum + ${digits:$i:1} * ${weights[$i]}))
    done
    sum=$((sum + digit1 * ${weights[12]}))
    remainder=$((sum % 11))
    local digit2=$((remainder < 2 ? 0 : 11 - remainder))

    if [[ "$formatted" == true ]]; then
        echo "${digits:0:2}.${digits:2:3}.${digits:5:3}/${digits:8:4}-${digit1}${digit2}"
    else
        echo "${digits}${digit1}${digit2}"
    fi
}
