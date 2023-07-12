#!/bin/zsh

function sizeof()
{
    default=1000
    base=${2:-"$default"} # Regular person's default is 1000. Linux extremists might want to change this to 1024. ;)
    if [ "$base" -ne 1000 ] && [ "$base" -ne 1024 ]; then
        echo "Invalid base \"$base\". Please use either 1000 or 1024."
        exit 2
    fi

    passed_name=${1:-"."} # Default to pwd if not specified

    if [ -d "$passed_name" ]; then # it is a directory or default
        case "$base" in
            1000)
                # du --si -s is equivalent to -d 0:
                dirsizestring=$(du --si -s "$passed_name")
                formatted_dirsizestring=$(echo "$dirsizestring"|awk '{ print substr($1,0,(length($1)-1)), substr($1,length($1),1) "B" }')
                ;;
            1024)
                dirsizestring=$(du -sh "$passed_name")
                formatted_dirsizestring=$(echo "$dirsizestring"|awk '{ print substr($1,0,(length($1)-1)), substr($1,length($1),1) "iB" }')
                ;;
        esac

        dirsize=$(echo "$dirsizestring"|awk '{ print substr($1,0,(length($1)-1)) } ')
        if [ "$dirsize" = "0" ]; then
            # use different formatting than default if the directory is empty
            echo "0 B"
        else
            echo "$formatted_dirsizestring"
        fi

    elif [ -f "$passed_name" ]; then # is a file
        filesize=$(echo $(wc -c < "$passed_name"))

        i=0
        while [ $filesize -gt "$base" ]; do
            i=$((i+1))
            filesize=$((filesize/base))
        done

        case "$base" in
            1000)
                suffixes=" kMGTPEZY"
                formatted_filesize="$filesize ${suffixes:$i:1}B"
                ;;
            1024)
                suffixes=" KMGTPEZY"
                formatted_filesize="$filesize ${suffixes:$i:1}iB"
                ;;
        esac

        if [ "$filesize" -eq 0 ]; then
            # use different formatting than default if the file is empty
            echo "0 B"
        else
            echo "$formatted_filesize"
        fi

    else
        echo "\"$passed_name\" is not valid";
    fi
}


sizeof "$@"
