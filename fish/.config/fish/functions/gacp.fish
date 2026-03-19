function gacp
    read -P "Enter commit message: " msg
    if test -z "$msg"
        echo "Aborted: empty message"
        return
    end
    set branch (git branch --show-current)
    git add .
    git commit -m "$msg"
    git push origin $branch
end
