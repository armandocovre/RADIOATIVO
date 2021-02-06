Add-Type -AssemblyName presentationCore 
$mediaplayer=New-Object system.windows.media.mediaplayer
Register-ObjectEvent -InputObject $mediaplayer -SourceIdentifier media -EventName BufferingStarted -Action {write-host "media stopped"}
$mediaPlayer.Open('C:\TEMP\Fernanda.wav')
$mediaplayer.Play()
#sleep 3
#$mediaPlayer.Open('C:\Windows\Media\chimes.wav')
#$mediaplayer.Play()

