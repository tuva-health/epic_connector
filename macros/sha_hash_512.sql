{#-
    Creates a SHA2 512 hash
-#}

{%- macro sha_hash_512(column_name) -%}

    {{ return(adapter.dispatch('sha_hash_512')(column_name)) }}

{%- endmacro -%}

{%- macro default__sha_hash_512(column_name) %}

     sha2( {{ column_name }} , 512)

{%- endmacro -%}

{%- macro bigquery__sha_hash_512(column_name) -%}

    sha512( {{ column_name }} )

{%- endmacro -%}

{%- macro redshift__sha_hash_512(column_name) -%}

    sha2( {{ column_name }} , 512)

{%- endmacro -%}

{%- macro snowflake__sha_hash_512(column_name) %}

    sha2( {{ column_name }} , 512)

{%- endmacro -%}

{%- macro duckdb__sha_hash_512(column_name) %}

    sha256( {{ column_name }} )

{%- endmacro -%}