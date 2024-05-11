docker build -t debitpay/debitpay-backend:latest -t debitpay/debitpay-backend:v1.0 .
docker login
docker push debitpay/debitpay-backend:latest