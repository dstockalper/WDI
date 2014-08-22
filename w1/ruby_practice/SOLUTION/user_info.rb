abe_info = {
    'first name' => 'Abraham',
    'last name' => 'Lincoln',
    'email' => 'abe.killa@white-house.gov',
    'favorite food' => 'Monster Energy Drink'
}

jed_info = {
    'first name' => 'Josiah',
    'middle name' => 'Edward',
    'nickname' => 'Jed',
    'last name' => 'Bartlet',
    'email' => 'potus-maximus@white-house.gov',
    'favorite food' => 'caviar'
}

broken_info = {
    'first name' => 'Brosef',
    'email' => 'broski@internets',
    'middle name' => 'Abr0ham'
}

def get_full_name(personal_info)
    full_name = personal_info['first name']

    if personal_info.has_key?('middle name')
        full_name += ' '
        full_name += personal_info['middle name'][0]
        full_name += '. '
    end

    full_name += personal_info['last name']

    return full_name
end

def find_by_email(hashes_to_search, email)
    for info in hashes_to_search
        if info['email'] == email
            return info
        end
    end
end

def string_has_numbers?(some_string)
    numbers = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']

    for character in some_string.split('')
        if numbers.include?(character)
            return true
        end
    end

    return false
end

def validate_info(personal_info)
    required_keys = ['first name', 'last name', 'email']
    non_number_keys = ['first name', 'last name', 'middle name']

    problems = []

    for key in required_keys
        if !personal_info.has_key?(key)
            problems.push('This person\'s ' + key + ' is missing.')
        end
    end

    for key in non_number_keys
        value_to_check = personal_info[key]
        # completely missing
        if value_to_check.nil?
            next
        end
        if string_has_numbers?(value_to_check)
            problems.push('I\'m pretty sure ' + value_to_check + ' is not a ' + key + '.')
        end
    end

    if !personal_info['email'].include?('@') ||
        !personal_info['email'].include?('.')
        problems.push("'" + personal_info['email'] + "' is definitely not a real email.")
    end

    return problems
end

Kernel.puts(
    get_full_name(jed_info),
    '',
    find_by_email([jed_info, abe_info], 'abe.killa@white-house.gov'),
    '',
    validate_info(broken_info)
)
