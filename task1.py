# coding: utf-8
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

def get_data(path: str) -> pd.DataFrame:
    """Reading csv data

    Args:
        path (str): path to file

    Returns:
        pd.DataFrame: DataFrame
    """
    try:
        df = pd.read_csv(path)

    except Exception as e:
        print(e)
        return
    
    else:
        print('File read!')

    return df 


def get_statistics(df: pd.DataFrame) -> pd.DataFrame:
    """calculating basics statitistics like mean, min, max, etc.

    Args:
        df (pd.DataFrame): input data frame

    Returns:
        pd.DataFrame: statistics for each column 
    """
    return df.describe()
    


def create_pickle_disc(df: pd.DataFrame, output_path: str) -> None:
    """creating pickle data with changed formats

    Args:
        df (pd.DataFrame): input data frame
        output_path (str): path to write file
    """
    try:
        df[['Z', 'geoportal1', 'up421']] = df[['Z', 'geoportal1', 'up421']].astype(np.float32) 
        df.to_pickle(output_path)

    except Exception as e:
        print(e)
    
    else:
        print('File created!')


def get_pickle(path: str) -> pd.DataFrame:
    """reading data in pkl

    Args:
        path (str): path to file

    Returns:
        pd.DataFrame: Data Frame
    """
    try:
        df = pd.read_pickle(path)

    except Exception as e:
        print(e)

    else:
        print('File read!')


def show_plot(df: pd.DataFrame) -> None:
    """creating and showing simple plot 

    Args:
        df (pd.DataFrame): Data Frame
    """

    plt.figure(figsize=(8, 6))

    plt.plot(df['geoportal1'], label='geoportal1', color='orange')
    plt.plot(df['up421'], label='up421', color='red')

    # Adding labels, title, and legend
    plt.xlabel('Index')
    plt.ylabel('Value')
    plt.title('Line plot between geoportal1 and up421')
    plt.legend()
    plt.grid(True)
    plt.show()


if __name__ == '__main__':
    df = get_data('z_geoportal_up42.csv')
    print(get_statistics(df))
    create_pickle_disc(df, 'out.pkl')
    get_pickle('out.pkl')
    show_plot(df)
    
    

    