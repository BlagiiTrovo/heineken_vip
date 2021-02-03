## FiveM VIP Sistem za ESX 1.2

 Primer : Dajte VIP status igraču koji je donirao određenu sumu novca za pomoć zajednici kako bi mogao da pristupi VIP AUTO SALONU.


Admin komande : /dajvip & /uklonivip


					ESX.TriggerServerCallback('heineken_vip:getVIPStatus', function(isVIP)
						if isVIP then
							OpenShopMenu()
						else
							ESX.ShowNotification("Kao VIP igrač imate više mogućnosti. Posetite naš Discord server za više informacija.")
						end
					end, GetPlayerServerId(PlayerId()), '1')




