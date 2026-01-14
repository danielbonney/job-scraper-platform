import boto3
import requests
from bs4 import BeautifulSoup
from datetime import datetime
import json

def scrape_data():
    print("Scraping data...")
    sample_data = {
        "job_title": "Cloud Engineer",
        "company": "Target Company",
        "timestamp": datetime.now().isoformat()
    }
    return sample_data

def upload_to_s3(data):
    print(f"Ready to upload to dbonney-job-scraper-data")

if __name__ == "__main__":
    data = scrape_data()
    upload_to_s3(data)
