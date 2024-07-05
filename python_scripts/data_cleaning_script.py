import pandas as pd
import os

def convert_timedelta_to_hms(timedelta_str):
    timedelta = pd.to_timedelta(timedelta_str)
    total_seconds = int(timedelta.total_seconds())
    hours, remainder = divmod(total_seconds, 3600)
    minutes, seconds = divmod(remainder, 60)
    return f"{hours:02}:{minutes:02}:{seconds:02}"

# Apply the function to the ride_length column

def cleaning(df):
    print("Cleaning DataFrame...")
    print(df.isnull().sum())

    df['start_station_name'].fillna('Not Available', inplace=True)
    df['start_station_id'].fillna('Not Available', inplace=True)
    df['end_station_name'].fillna('Not Available', inplace=True)
    df['end_station_id'].fillna('Not Available', inplace=True)

    df.dropna(subset=['end_lat','end_lng'],inplace=True)

    df['started_at'] = pd.to_datetime(df['started_at'])
    df['ended_at'] = pd.to_datetime(df['ended_at'])

    df['ride_length'] = df['ended_at'] - df['started_at']
    df = df[df['ride_length'] >= pd.Timedelta(0)]
    df['ride_length'] = df['ride_length'].apply(convert_timedelta_to_hms)

    df['day_of_week'] = df['started_at'].dt.day_of_week + 1

    return df

def process_files_in_directory(directory,cleaned_directory):
    finaldfs = []
    for filename in os.listdir(directory):
        if filename.endswith(".csv"):
            filepath = os.path.join(directory, filename)
            print(f"Processing file: {filename}")
            df = pd.read_csv(filepath)
            cleaned_df = cleaning(df)
            finaldfs.append(cleaned_df)
            # Save cleaned DataFrame back to CSV or perform other operations
            cleaned_filepath = os.path.join(cleaned_directory, f"cleaned_{filename}")
            cleaned_df.to_csv(cleaned_filepath, index=False)
            print(f"Cleaned data saved to: {cleaned_filepath}")
            print()
    full_year_df = pd.concat(finaldfs,ignore_index=True)
    finalname = "full_year_combined.csv"
    finalpath = os.path.join(cleaned_directory,finalname)
    full_year_df.to_csv(finalpath,index=False)
    print(f"Final dataset saved to {finalpath}")

if __name__ == '__main__':
    directory_path = r"C:\Users\raman\Desktop\Courses\Google_DA\Capstone\datasets"
    cleaned_directory = r"C:\Users\raman\Desktop\Courses\Google_DA\Capstone\cleaned_datasets"
    process_files_in_directory(directory_path,cleaned_directory)