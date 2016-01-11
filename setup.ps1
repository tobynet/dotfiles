$files='.gitconfig', '.gvimrc', '.tigrc', '.tmux.conf', '.vimrc', '.zshrc', '.ghci'


# ----

function isSymboliLink($path) {
    (Test-Path $path) -and ((Get-Item $path).Attributes.ToString() -match "Reparse")
}

function makeSymbolicLink($originalPath, $linkPathToCreate) {
    # cmd /c mklink <link_path_to_create> <original_path>
    New-Item -ItemType SymbolicLink -Path $linkPathToCreate -Value $originalPath
}

# ----

echo "Run as Administrator..."
If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{    
    $path = $MyInvocation.MyCommand.Path
    Start-Process powershell -ArgumentList "-noprofile -file $path" -verb RunAs
    Break
}

$targetDirectory = $HOME

cd $PSScriptRoot

echo "Configurations:"
echo "  Current Directory: $PWD.Path"
echo "  TargetDirectory: $targetDirectory"
echo ""

echo "# Make Symbolic Links"

ForEach ($path in $files) {
    $private:originalPath = $(Join-Path $PWD $path)
    $private:linkPathToCreate = $(Join-Path $targetDirectory $path)
    echo "  Make symbolic link: $originalPath -> $linkPathToCreate ..."

    if (isSymboliLink($linkPathToCreate)) {
        # Remove it if target path is a Symbolic Link.
        echo "  Removing $linkPathToCreate ..."
        Remove-Item $linkPathToCreate
    } elseif (Test-Path $linkPathToCreate) {
        # Keep existen file if target path is NOT a symlink.
        echo "  Backup $linkPathToCreate -> $linkPathToCreate.bak"
        Move-Item $linkPathToCreate "$linkPathToCreate.bak"
    }

    makeSymbolicLink $originalPath $linkPathToCreate 
    echo ""
}


$files | % { Join-Path $targetDirectory $_ } | ls

pause