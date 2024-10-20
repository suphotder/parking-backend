# How to run Back-End

## Run PostgreSQL
- Start docker
- Open project and open terminal
```frontend
docker-compose -f dev.yml up
```
## Run parking-backend
- Open new terminal
```frontend
python3 -m venv .venv
pip install -r requirements.txt
python3 main.py 
```
# How to run Front-End
- Connect to the Internet
- Open new terminal
```frontend
cd parking
flutter pub get
flutter run -d chrome
```
# How to use the program
- Click dropdown
<div align="center">
  <img src="./assets/Screenshot1" alt="Project screenshot" width="80%">
</div>
- Select location
<div align="center">
  <img src="./assets/Screenshot2.png" alt="Project screenshot" width="80%">
</div>
<div align="center">
  <img src="./assets/Screenshot3.png" alt="Project screenshot" width="80%">
</div>
