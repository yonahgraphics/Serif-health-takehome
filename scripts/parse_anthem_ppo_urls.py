from pyspark.sql import SparkSession
from pyspark.sql.functions import explode, col, when, lit, lower
from pyspark.sql.types import ArrayType
import time

# Capture current time
time_before_run = time.time()

# Create a Spark session
spark = SparkSession.builder.appName("Serif take-home").getOrCreate()

# Define the path to the JSON file
json_path = "../2024-01-01_anthem_index.json.gz"
# Read the JSON file
df = spark.read.json(json_path)

# Explode the nested arrays
df = df.withColumn("plans", explode("reporting_plans")) \
       .withColumn("in_network", explode("in_network_files"))

# Check the type of 'allowed_amount_file'
if isinstance(df.schema["allowed_amount_file"].dataType, ArrayType):
    # If it is an array, explode directly
    df = df.withColumn("allowed_amount", explode("allowed_amount_file"))
else:
    # If it's not an array (i.e., a struct or null), handle it differently
    df = df.withColumn("allowed_amount", when(col("allowed_amount_file").isNotNull(), col("allowed_amount_file")).otherwise(lit(None)))

# Filtering for Anthem PPO plans using the 'plans' column
anthem_ppo_df = df.filter(
    lower(col("plans.plan_name")).rlike(".*anthem.*") &
    lower(col("plans.plan_name")).rlike(".*ppo.*") &
    lower(col("plans.plan_name")).rlike(".*new york.*")
)

# Selecting the required columns
anthem_ppo_urls_df = anthem_ppo_df.select(
    col("in_network.location").alias("in_network_url"),
    col("allowed_amount.location").alias("allowed_amount_url")
)

# Removing duplicates
unique_urls_df = anthem_ppo_urls_df.distinct()

# Collecting the URLs
unique_urls = unique_urls_df.collect()

# Define the path for the output file
output_path = "../anthem_ppo_urls.csv"

# Write the DataFrame to a CSV file
unique_urls_df.coalesce(1).write.csv(output_path, header=True, mode="overwrite")

time_after_run = time.time()
# Stop the Spark session
spark.stop()

# Print the time taken to run the script
time_diff = time_after_run - time_before_run
print("This took", time_diff, "Seconds")