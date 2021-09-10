import requests
import pandas as pd
from bs4 import BeautifulSoup

chicago = requests.get(url='https://code.s3.yandex.net/data-analyst-eng/chicago_weather_2017.html')

chicago_soup = BeautifulSoup(chicago.text, features='html.parser')

td_data = []
for row in chicago_soup.find_all('td'):
    td_data.append(str(row).strip('</td>'))

th_data = []
for row in chicago_soup.find_all('th'):
    th_data.append(str(row).strip('</th>'))

weather_records = pd.DataFrame(
    data=[
        [
            td_data[3*i], 
            td_data[3*i+1], 
            td_data[3*i+2]
        ] for i in range(697)
        ],
    columns=[th_data[j] for j in range(len(th_data))]
    )

print(weather_records)