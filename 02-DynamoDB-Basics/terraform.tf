provider "aws" {
    version = "~> 2.0"
    region = "us-west-2"
}

resource "aws_dynamodb_table" "students_table" {
    name = "lo_student"
    billing_mode = "PROVISIONED"
    read_capacity = 1
    write_capacity = 1
    hash_key = "s_id"
    
    attribute {
        name = "s_id"
        type = "N"
    }
}

resource "aws_dynamodb_table" "teachers_table" { 
    name = "lo_teachers"
    read_capacity = 1
    write_capacity = 1
    hash_key = "t_id"

    attribute {
        name = "t_id"
        type = "N"
    }
}

resource "aws_dynamodb_table" "modules_table" {
    name = "lo_modules"
    read_capacity = 1
    write_capacity = 1
    hash_key = "m_id"

    attribute {
        name = "m_id"
        type = "N"
    }
}

resource "aws_dynamodb_table" "courses_table" {
    name = "lo_courses"
    read_capacity = 1
    write_capacity = 1
    hash_key = "c_id"

    attribute {
        name = "c_id"
        type = "N"
    }
}

resource "aws_dynamodb_table" "courseinstances_table" { 
    name = "lo_courseinstances"
    read_capacity = 1
    write_capacity = 1
    hash_key = "ci_id"

    attribute {
        name = "ci_id"
        type = "N"
    }
}

resource "aws_dynamodb_table" "attendance_table" {
    name = "lo_attendance"
    read_capacity = 1
    write_capacity = 1
    hash_key = "b_id"
    range_key = "s_id"

    attribute {
        name = "b_id"
        type = "N"
    }

    attribute {
        name = "s_id"
        type = "N"
    }
}

resource "aws_dynamodb_table" "exams_table" {
    name = "lo_exams"
    read_capacity = 1
    write_capacity = 1
    hash_key = "e_id"

    attribute {
        name = "e_id"
        type = "N"
    }
}

resource "aws_dynamodb_table" "bookings_table" {
    name = "lo_bookings"
    read_capacity = 1
    write_capacity = 1
    hash_key = "b_id"
    range_key = "ci_id"

    attribute {
        name = "b_id"
        type = "N"
    }

    attribute {
        name = "ci_id"
        type = "N"
    }
}

resource "aws_dynamodb_table" "studentgroups_table" {
    name = "lo_studentgroups"
    read_capacity = 1
    write_capacity = 1
    hash_key = "g_id"
    range_key = "ci_id"

    attribute {
        name = "g_id"
        type = "N"
    }

    attribute {
        name = "ci_id"
        type = "N"
    }
}

resource "aws_dynamodb_table" "counters_table" {
    name = "lo_counters"
    read_capacity = 1
    write_capacity = 1
    hash_key = "countername"

    attribute {
        name = "countername"
        type = "S"
    }
}