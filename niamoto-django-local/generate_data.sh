echo "Generate Data"
python ~/niamoto-portal/manage.py dumpdata --exclude auth.permission  --exclude=contenttypes > /home/niamoto/data.json
echo "Move data"
sudo mv ~/data.json ~/data