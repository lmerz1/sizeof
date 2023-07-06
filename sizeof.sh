# no shebang as this is not meant to be kept in/executed from a separate file,
# used most easily by pasting the entire function into your .*shrc file

function sizeof()
{
    powersof=1000 # Regular person's default. Linux extremists might want to change this to 1024. ;)

    passed_name="$1"

    if [ -z "$passed_name" ]; then
        passed_name="." # fallback to pwd
    fi

    if   [ -d "$passed_name" ]; then # is a directory or we default to current pwd
        if [ "$powersof" -eq 1000 ]; then
            # du --si -s is equivalent to -d 0:
            du --si -s "$passed_name"|awk '{ print substr($1,0,(length($1)-1)), substr($1,length($1),1) "B" }'
        else
            du -sh "$passed_name"|awk '{ print substr($1,0,(length($1)-1)), substr($1,length($1),1) "B" }'
        fi
    elif [ -f "$passed_name" ]; then # is a file

        filesize=$(echo $(wc -c < "$passed_name"))

        i=0
        s=" kMGTPEZY" # lowercase k to imitate behavior of `du` for the sake of consistency
        while [ $filesize -gt "$powersof" ]; do
            i=$((i+1))
            filesize=$((filesize/powersof))
        done
        echo "$filesize ${s:$i:1}B"
    else echo "\"$passed_name\" is not valid";
        #exit 1  ## not exiting the (main) shell session here due to this function being defined within .*shrc files
    fi
}

alias si="sizeof"
alias sof="sizeof"


sizeof "$1"
