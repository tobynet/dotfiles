$files='.gitconfig', '.gvimrc', '.tigrc', '.tmux.conf', '.vimrc', '.zshrc', '.ghci'


# ----

function isSymboliLink($path) {
    (Test-Path $path) -and ((Get-Item $path).Attributes.ToString() -match "Reparse")
}

function makeSymbolicLink($originalPath, $linkPathToCreate) {
    & "$env:ComSpec" /c mklink $linkPathToCreate $originalPath
    #New-Item -ItemType SymbolicLink -Path $linkPathToCreate -Value $originalPath
}

# ----

$targetDirectory = $HOME

Set-Location $PSScriptRoot

Write-Host "Configurations:"
Write-Host "  Current Directory: $PWD.Path"
Write-Host "  TargetDirectory: $targetDirectory"
Write-Host ""

Write-Host "# Make Symbolic Links"

Push-Location $targetDirectory

ForEach ($path in $files) {
    $private:originDir = Get-Location -stack    # => ~/dotfiles
    $private:relativeDir = Resolve-Path -Relative $originDir    # => ./dotfiles

    $private:originalPath = Join-Path $relativeDir $path    # => ./dotfiles/.gitconfig 
    $private:linkPathToCreate = $path   # => .gitconfig

    Write-Host "  Make symbolic link: $originalPath -> $linkPathToCreate ..."

    if (isSymboliLink($linkPathToCreate)) {
        # Remove it if target path is a Symbolic Link.
        Write-Host "  Removing $linkPathToCreate ..."
        Remove-Item $linkPathToCreate
    } elseif (Test-Path $linkPathToCreate) {
        # Keep existen file if target path is NOT a symlink.
        Write-Host "  Backup $linkPathToCreate -> $linkPathToCreate.bak"
        Move-Item $linkPathToCreate "$linkPathToCreate.bak"
    }

    makeSymbolicLink $originalPath $linkPathToCreate 
    Write-Host ""
}

Pop-Location

# Show target files
#$files | % { Join-Path $targetDirectory $_ } | ls
& "$env:ComSpec" /c "dir $targetDirectory | findStr SYMLINK"

pause