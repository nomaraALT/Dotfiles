#Set-ExecutionPolicy -ExecutionPolicy bypass -Scope Process -Force

$DotfileLocation = Get-Location

function CreateDirectory
{
    [CmdletBinding()]
        param (
                [Parameter(Mandatory = $true)] [string] $DirectoryToCreate
              )

            if(-not (Test-Path -LiteralPath $DirectoryToCreate)) {
                try {
                    Write-Host "------[*] Creating directory '$DirectoryToCreate'."
                        New-Item -Path $DirectoryToCreate -ItemType Directory -ErrorAction Stop | Out-Null
                }
                catch {
                    Write-Error -Message "Unable to create directory '$DirectoryToCreate'. ERROR was: $_" -Error
                }
            }
            else {
                Write-Host "---[ ] Directory '$DirectoryToCreate' already existed."
            }
}

function CopyFile
{
    [CmdletBinding()]
        param (
                [Parameter(Mandatory = $true)] [string] $FileToCopy,
                [Parameter(Mandatory = $true)] [string] $PathToFile
              )

            if(-not (Test-Path -LiteralPath ($PathToFile))){
                try {
                    Write-Host "------[*] Copying file '$FileToCopy' to '$PathToFile'."
                        Copy-Item -Path $FileToCopy -Destination $PathToFile -ErrorAction Stop | Out-Null
                }
                catch {
                    Write-Error -Message "Unable to copy file to '$PathToFile'. ERROR was: $_" -Error
                }
            }
            else {
                Write-Host "---[ ] File '$FileToCopy' already existed in '$PathToFile'."
            }

}

CreateDirectory -DirectoryToCreate "$HOME/.vim"
CreateDirectory -DirectoryToCreate "$HOME/vimfiles"
CreateDirectory -DirectoryToCreate "$HOME/.vim/undo-dir"
CopyFile -FileToCopy "_vimrc" -PathToFile "$HOME/_vimrc"
CopyFile -FileToCopy "coc-settings.json" -PathToFile "$HOME/vimfiles/coc-settings.json"

if(-not (Test-Path -LiteralPath "$HOME/vimfiles/autoload/plug.vim")) {
    Write-Host "-----[*] Downloading vim-plug. Requeride for vim plugins"
    Invoke-WebRequest -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
        New-Item $HOME/vimfiles/autoload/plug.vim -Force | Out-Null
}

if(-not (Test-Path -LiteralPath "$HOME/vimfiles/ctags")) {
    try {
        Write-Host "-----[*] Downloading ctags. Requeride for tagbar vim."
            &git clone https://github.com/universal-ctags/ctags.git $HOME/vimfiles/ctags
            Start-Sleep -s 3
            &Set-Location -Path "$HOME\vimfiles\ctags"
            &nmake -f mk_mvc.mak
            &Set-Location -Path $DotfileLocation
    }
    catch {
            Write-Host "Unable to Download and compile 'ctags' for tagbar vim"
    }
 }

Remove-Variable DotfileLocation

if ((Get-Command "python.exe" -ErrorAction SilentlyContinue) -eq $null)
{
    Write-Host " 'python.exe' not found in PATH."
}
else
{
        try {
                &pip install -U jedi-language-server
        }
        catch {
            Write-Host "Unable to run 'pip'"
        }
}

if ((Get-Command "luarocks.exe" -ErrorAction SilentlyContinue) -eq $null)
{
    Write-Host " 'luarocks.exe' not found in PATH."
}
else
{
        try {
                &luarocks install --server=http://luarocks.org/dev lua-lsp
                Start-Sleep -s 3
                &luarocks install luacheck
        }
        catch {
            Write-Host "Unable to run 'luarocks'"
        }
}

if ((Get-Command "gvim.exe" -ErrorAction SilentlyContinue) -eq $null)
{
    Write-Host " 'gvim.exe' not found in PATH."
}
else
{
    try {
            &gvim -c "PlugInstall"
    }
    catch {
        Write-Host "Unable to run 'PlugInstall'. You must to do manually."
    }

    if((Get-Process -Name "gvim" -ErrorAction SilentlyContinue) -cne $null) {
        Start-Sleep -s 60 # 1 minutes. I need to wait for vim-plug install the plugins.
            Stop-Process -Name "gvim"
            Start-Sleep -s 3
    }

    try {
        &gvim -c "CocInstall coc-json coc-tsserver coc-lua coc-phpls coc-powershell coc-go coc-html coc-snippets coc-yank coc-css coc-cmake coc-jedi coc-marketplace coc-clangd"
    }
    catch {
        Write-Host "Unable to run 'CocInstall'. You must to do manually."
    }
}


Write-Host "---[*][*][*] script finished [*][*][*]---"
