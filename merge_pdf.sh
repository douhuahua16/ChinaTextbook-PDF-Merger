#!/system/bin/sh

# Merge ChinaTextbook binary PDF parts (*.pdf.1, *.pdf.2, ...)
# Usage: sh merge_pdf.sh /sdcard/Download

DIR="${1:-.}"

find "$DIR" -type f -name '*.pdf.1' | while IFS= read -r first; do
    base="${first%.1}"
    name="${base##*/}"

    echo "正在处理：$name"

    if [ -e "$base" ]; then
        echo "跳过：目标 PDF 已存在"
        continue
    fi

    i=1
    while [ -f "$base.$i" ]; do
        i=$((i + 1))
    done

    # Check for gaps in the available part numbers.
    max=0
    for part in "$base".[0-9]*; do
        [ -f "$part" ] || continue
        num="${part##*.}"
        case "$num" in
            ''|*[!0-9]*) continue ;;
        esac
        num=$((num + 0))
        [ "$num" -gt "$max" ] && max="$num"
    done

    if [ "$max" -ne $((i - 1)) ]; then
        echo "跳过：分片不连续"
        continue
    fi

    tmp="$base.merging"
    : > "$tmp" || continue

    n=1
    ok=1
    while [ "$n" -le "$max" ]; do
        cat "$base.$n" >> "$tmp" || {
            ok=0
            break
        }
        n=$((n + 1))
    done

    if [ "$ok" -eq 1 ] && mv "$tmp" "$base"; then
        echo "合并成功：$name"
    else
        rm -f "$tmp"
        echo "合并失败：$name"
    fi
done

echo "全部处理完成"
