#!/bin/zsh

function sizeof()
{
    if [ -z "$2" ]; then
        powersof=1000 # Regular person's default. Linux extremists might want to change this to 1024. ;)
    else
        if [ "$2" != 1024 ] && [ "$2" != 1000 ] ; then
            echo "Change the code if you would like to use a \"base\" different from 1000 or 1024."
            exit 2
        fi
        powersof="$2" # now is 1024 (or 1000)
    fi


    passed_name="$1"

    if [ -z "$passed_name" ]; then
        passed_name="." # fallback to pwd
    fi

    if   [ -d "$passed_name" ]; then # is a directory or we default to current pwd
        if [ "$powersof" -eq 1000 ]; then
            # du --si -s is equivalent to -d 0:
            dirsizestring=$(du --si -s "$passed_name")
        else # 1024
            dirsizestring=$(du -sh "$passed_name")
        fi

        dirsize=$(echo "$dirsizestring"|awk '{ print substr($1,0,(length($1)-1)) } ')
        if [ "$dirsize" = "0" ]; then
            # use different formatting than default if the directory is empty
            echo "0 B"
        else
            echo "$dirsizestring"|awk '{ print substr($1,0,(length($1)-1)), substr($1,length($1),1) "B" }'
        fi

    elif [ -f "$passed_name" ]; then # is a file
        filesize=$(echo $(wc -c < "$passed_name"))

        i=0
        if [ "$powersof" -eq 1000 ]; then
            s=" kMGTPEZY" # lowercase k in this case to imitate behavior of `du` for the sake of consistency
        else
            s=" KMGTPEZY" # 1024 used
        fi
        
        while [ $filesize -gt "$powersof" ]; do
            i=$((i+1))
            filesize=$((filesize/powersof))
        done

        if [ "$filesize" = "0" ]; then
            # use different formatting than default if the file is empty
            echo "0 B"
        else
            echo "$filesize ${s:$i:1}B"
        fi
    else echo "\"$passed_name\" is not valid";
        exit 1  ## not exiting the (main) shell session here due to this function being defined within .*shrc files
    fi
}

# alias si="sizeof.sh"
# alias sof="sizeof.sh"


sizeof "$@"
