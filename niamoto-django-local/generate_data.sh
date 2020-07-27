echo "Generate Data"
python ~/niamoto-portal/manage.py dumpdata > /home/niamoto/data.json
echo "Move data"
sudo mv ~/data.json ~/data