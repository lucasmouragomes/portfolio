from pyspark.sql import SparkSession

APP_NAME = "DataFrames"
SPARK_URL = "local[*]"

spark = SparkSession.builder.appName(APP_NAME).getOrCreate()

taxi = spark.read.load('./datasets/pickups_terminal_5.csv', 
                       format='csv', header='true', inferSchema='true')

taxi = taxi.fillna(0)

taxi.registerTempTable("taxi")

print(spark.sql(
                'SELECT pickups FROM taxi ORDER BY pickups DESC'
                ).show(5)
     )