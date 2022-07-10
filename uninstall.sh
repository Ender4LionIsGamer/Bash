echo "Uninstalling lua..."
echo "Are you sure you want to uninstall lua? (Yes/No)"
read uninstall

if $uninstall == 'Yes' then
    sudo apt purge --autoremove -y lua > uninstall.log
if $uninstall == 'No' then
    exit
