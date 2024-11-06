from pyspark.sql import SparkSession
from pyspark.sql.functions import col


def main():
    # Initialize a SparkSession
    spark = SparkSession.builder \
        .appName("Simple Spark Test Application") \
        .getOrCreate()

    # Load a dataset (we'll create a simple dataset if "people.json" is not available)
    data = [("James", "Smith", "M", 30),
            ("Anna", "Rose", "F", 41),
            ("Robert", "Williams", "M", 62)]

    columns = ["FirstName", "LastName", "Gender", "Age"]
    df = spark.createDataFrame(data, schema=columns)

    # Show the DataFrame
    df.show()

    # Perform a simple transformation: filter by age
    filtered_df = df.filter(col("Age") > 40)
    print("People older than 40:")
    filtered_df.show()

    # Perform an aggregation: count by gender
    gender_count = df.groupBy("Gender").count()
    print("Count by gender:")
    gender_count.show()

    # Stop the SparkSession
    spark.stop()


if __name__ == "__main__":
    main()
