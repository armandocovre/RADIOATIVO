$mediaPlayer = New-Object system.windows.media.mediaplayer
$path = "L:\arquivos\musicas" #nao esqueca de trocar aqui o caminho do diretorio das suas musicas
$files = Get-ChildItem -path $path -include *.mp3 -recurse
 
foreach($file in $files)
{
 "Tocando $($file.BaseName)"
 $mediaPlayer.open([uri]"$($file.fullname)")
 $mediaPlayer.Play()
 Start-Sleep -Seconds 30 #tem que especificar um tempo para ele tocar, estou tentando melhorar esta parte
 $mediaPlayer.Stop()
}