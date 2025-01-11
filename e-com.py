import mysql.connector
from mysql.connector import Error
from http.server import BaseHTTPRequestHandler, HTTPServer
import json

# Database connection
def create_connection():
    try:
        connection = mysql.connector.connect(
            host='localhost',
            user='root',  # Replace with your MySQL username
            password='root',  # Replace with your MySQL password
            database='ecommerce_db'  # Replace with your database name
        )
        if connection.is_connected():
            return connection
    except Error as e:
        print(f"Error while connecting to MySQL: {e}")
        return None

# Fetch all products
def get_products():
    try:
        connection = create_connection()
        if connection:
            cursor = connection.cursor(dictionary=True)
            cursor.execute("SELECT * FROM products")
            products = cursor.fetchall()
            cursor.close()
            connection.close()
            return products
        else:
            return {"error": "Database connection failed"}
    except Exception as e:
        print(f"Error fetching products: {e}")
        return {"error": str(e)}

# Fetch all users
def get_users():
    try:
        connection = create_connection()
        if connection:
            cursor = connection.cursor(dictionary=True)
            cursor.execute("SELECT * FROM users")
            users = cursor.fetchall()
            cursor.close()
            connection.close()
            return users
        else:
            return {"error": "Database connection failed"}
    except Exception as e:
        print(f"Error fetching users: {e}")
        return {"error": str(e)}

# Fetch all orders
def get_orders():
    try:
        connection = create_connection()
        if connection:
            cursor = connection.cursor(dictionary=True)
            cursor.execute("SELECT * FROM orders")
            orders = cursor.fetchall()
            cursor.close()
            connection.close()
            return orders
        else:
            return {"error": "Database connection failed"}
    except Exception as e:
        print(f"Error fetching orders: {e}")
        return {"error": str(e)}

# Request handler for the HTTP server
class RequestHandler(BaseHTTPRequestHandler):

    def do_GET(self):
        if self.path == '/products':
            self.send_response(200)
            self.send_header('Content-type', 'application/json')
            self.end_headers()
            products = get_products()
            self.wfile.write(json.dumps(products, default=str).encode())

        elif self.path == '/users':
            self.send_response(200)
            self.send_header('Content-type', 'application/json')
            self.end_headers()
            users = get_users()
            self.wfile.write(json.dumps(users, default=str).encode())

        elif self.path == '/orders':
            self.send_response(200)
            self.send_header('Content-type', 'application/json')
            self.end_headers()
            orders = get_orders()
            self.wfile.write(json.dumps(orders, default=str).encode())

        else:
            self.send_response(404)
            self.send_header('Content-type', 'text/html')
            self.end_headers()
            self.wfile.write(b"Page not found")

# Run the server
def run(server_class=HTTPServer, handler_class=RequestHandler, port=9090):
    server_address = ('', port)
    httpd = server_class(server_address, handler_class)
    print(f'Starting server on port {port}...')
    httpd.serve_forever()

if __name__ == "__main__":
    run()
