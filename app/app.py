from flask import Flask, Response, json
import redis

''' simple health check with redis ping, if connection is not etablished returns 500, and if connection is up but no answer to ping '''

app = Flask(__name__)
app.redis = redis.Redis(host='localhost',port= 6379)

@app.route("/health")
def health():
  if app.redis.ping():
        status = Response(json.dumps('status: OK'), status=200, mimetype='application/json')
  else:
        status = Response(json.dumps('status: NOK'), status=500, mimetype='application/json')
  return status

if __name__ == "__main__":
  app.run(host='0.0.0.0', port=5000)
