import pandas as pd
import requests
from bs4 import BeautifulSoup
import re

def to_csv(url, csv_path):
    # Send an HTTP GET request to the website
    response = requests.get(url)
    # Parse the HTML code using BeautifulSoup
    soup = BeautifulSoup(response.content, 'html.parser')
    # Extract the relevant information from the HTML code
    # Select all tables with the class 'wikitable'
    tables = soup.select('#mw-content-text > div.mw-content-ltr.mw-parser-output > table.wikitable')
    # Extract villa names, grid references, and links from all selected tables
    data = []
    for table in tables:
        for row in table.find_all('tr')[1:]:  # Skip the header row
            cells = row.find_all('td')
            if len(cells) >= 4: 
                # Ensure there are enough columns
                villa_name = cells[0].get_text(strip=True)
                villa_name = re.sub(r'[^a-zA-Z]', '', villa_name)

                wiki_link_text = cells[1].get_text(strip=True)
                wiki_link = cells[1].find('a')['href']

                grid_reference = cells[2].get_text(strip=True)

                link_tag = cells[3].find('a')
                link = link_tag['href'] if link_tag else 'N/A'
                wiki_link = str.replace(wiki_link, ',', '') if wiki_link else 'N/A'
                wiki_link = str.replace(wiki_link, '"', '') if wiki_link else 'N/A'
                wiki_link_text = str.replace(wiki_link_text, ',', '')
                wiki_link_text = str.replace(wiki_link_text, '"', '')
                data.append({'Villa Name': villa_name, 'Wiki Link Text': wiki_link_text, 'Wiki Link': wiki_link,
                             'Grid Reference': grid_reference, 'Link': link})
    # Create a DataFrame
    df = pd.DataFrame(data)
    # Export to CSV
    df.to_csv(csv_path, index=False)
