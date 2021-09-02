# This file contains all the code used in the codelab. 
import sqlalchemy
import logging
from flask import Flask, render_template, request, Response

logger = logging.getLogger()
app = Flask(__name__)

# Depending on which database you are using, you'll set some variables differently. 
# In this code we are inserting only one field with one value. 
# Feel free to change the insert statement as needed for your own table's requirements.

# Uncomment and set the following variables depending on your specific instance and database:
connection_name = "drone-shuttles:europe-west2:cloudrundb"
db_name = "cloudrundb"
db_user = "cloudrun"
db_password = "cloudrun"
db_table = "emails"

# If your database is MySQL, uncomment the following two lines:
driver_name = 'mysql+pymysql'
query_string = dict({"unix_socket": "/cloudsql/{}".format(connection_name)})

# If the type of your table_field value is a string, surround it with double quotes.
@app.route("/", methods=["POST"])
def delete(request):
    # confirmed = request.form["confirmed"]
    # if (confirmed != "yes"):
    #   return Response(
    #     status=200,
    #     response="Nothing done, until the confirmed = 'yes'")
    
    stmt = sqlalchemy.text ('delete from '+ db_table )
    
    db = sqlalchemy.create_engine(
      sqlalchemy.engine.url.URL(
        drivername=driver_name,
        username=db_user,
        password=db_password,
        database=db_name,
        query=query_string,
      ),
      pool_size=5,
      max_overflow=2,
      pool_timeout=30,
      pool_recycle=1800
    )
    try:
        with db.connect() as conn:
            res = conn.execute(stmt)
            logger.info ("'{}' deleted from '{}'".format(res, db_table))
    except Exception as e:
        # If something goes wrong, handle the error in this section. This might
        # involve retrying or adjusting parameters depending on the situation.
        # [START_EXCLUDE]
        logger.exception(e)
        return Response(
            status=500,
            response="Unable to successfully cast vote! Please check the "
            "application logs for more details.",
        )
    return Response(
        status=200,
        response="'All data deleted from '{}' ".format (db_table)
    )