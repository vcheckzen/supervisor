function print_divider()
{
    for (x = 0; x < cols; x++) printf "="
}

function cal_cols_format(titles, cols_prop)
{
    for (kcp in cols_prop) props_sum += cols_prop[kcp]
    for (i = 1; i < length(titles); i++) {
        needed_cols = int(cols_prop[i] / props_sum * (cols - 1))
        used_cols += needed_cols
        cols_fmt[i] = "%-" needed_cols "s"
    }
    cols_fmt[i] = "%" cols - used_cols - 2 "s\n"
}

function print_line(line)
{
    printf " "
    for (kcf = 1; kcf <= length(cols_fmt); kcf++)
        printf cols_fmt[kcf], line[kcf]
}

BEGIN {
    split("2 2 1 1 1 1 3", cols_prop)
    split("PROCESS_NAME GROUP STATUS PID CPU MEM START_TIME", titles)

    cal_cols_format(titles, cols_prop)
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
