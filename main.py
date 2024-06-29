import CsvToXml
import ToHtml
import CoordinateConverter
import ToCsv

# url to scrape
url = "https://en.wikipedia.org/wiki/List_of_Roman_villas_in_England"

# Path to the output CSV file
csv_path = 'roman_villas.csv'

# Perform the scraping of provided url, conversion of results, and saving to local file
ToCsv.to_csv(url, csv_path)

print('CSV file has been created successfully.')

# Paths to the input and output CSV files
input_csv_path = 'roman_villas.csv'
output_csv_path = 'roman_villas_with_lat_lon.csv'

# Perform the conversion
CoordinateConverter.convert_csv_coordinates(input_csv_path, output_csv_path)

print(f"Conversion complete. The output CSV has been saved to {output_csv_path}")

xml = CsvToXml.csv_to_xml(output_csv_path)

with open('roman_villas.xml', 'w') as file:
    file.write(xml)

# Paths to the XML, XSLT, and output HTML files
xml_file_path = 'roman_villas.xml'
xslt_file_path = 'ToSimpleHtml.xsl'
output_html_path = 'SimpleHtml.html'

# Perform the transformation and save the output
ToHtml.transform_xml_with_xslt(xml_file_path, xslt_file_path, output_html_path)

print(f"Transformation complete. The output HTML has been saved to {output_html_path}")
