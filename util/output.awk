function print_divider(    i)
{
    for (i = 0; i < cols; i++) printf "="
}

function cal_cols_format(   i, len)
{
    for (len in cols_prop) props_sum += cols_prop[len]
    for (i in titles) {
        if (i == len) break
        needed_cols = int(cols_prop[i] / props_sum * (cols - 1))
        used_cols += needed_cols
        cols_fmt[i] = "%-" needed_cols "s"
    }
    cols_fmt[len] = "%" cols - used_cols - 2 "s\n"
}

function print_line(line    ,i)
{
    printf " "
    for (i in cols_fmt)
        printf cols_fmt[i], line[i]
}

BEGIN {
    split("2 2 1 1 1 1 3", cols_prop)
    split("PROCESS_NAME GROUP STATUS PID CPU MEM START_TIME", titles)

    cal_cols_format()
    print_divider()
    print_line(titles)
    print_divider()
}

/^[\s]*$/ { next }

{
    split($0, line)
    if ($3 == "RUNNING") 
        line[7] = $7 " " $8 " " $9 " " $10 " " $11
    print_line(line)
}
