import requests
import json
import boto3
from datetime import datetime

def scrape_jobs():
    # Simulation of scraping logic
    jobs = [
        {"title": "Platform Engineer", "company": "TechCorp", "location": "Remote"},
        {"title": "DevOps Architect", "company": "CloudScale", "location": "New York"}
    ]
    return jobs

def upload_to_s3(data):
    s3 = boto3.client('s3')
    bucket_name = 'dbonney-job-scraper-data'
    file_name = f"jobs_{datetime.now().strftime('%Y-%m-%d_%H-%M')}.json"
    
    s3.put_object(
        Bucket=bucket_name,
        Key=file_name,
        Body=json.dumps(data, indent=2)
    )
    print(f"Successfully uploaded {file_name} to {bucket_name}")

if __name__ == "__main__":
    job_data = scrape_jobs()
    upload_to_s3(job_data)
