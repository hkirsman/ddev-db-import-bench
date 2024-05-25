# DDEV db benchmark

This is a simple DDEV repository for testing MariaDB and MySQL import speed. There are two branches available: `mariadb` and `mysql8`. Both branches have a similar setup, with the only difference being the database configuration.

## Getting Started

To get started with this repository, follow these steps:

1. Clone the repository to your local machine:

    ```shell
    git clone https://github.com/hkirsman/ddev-db-import-bench.git
    ```

2. Switch to the desired branch:

    ```shell
    git checkout mariadb
    ```

    or

    ```shell
    git checkout mysql8
    ```

3. Run the test script (you need db.sql in the same folder):

    ```shell
    ./test.sh
    ```

## Configuration

The database configuration for each branch is specified in the `.ddev/config.yaml` file. Make sure to update this file according to your requirements.

## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvements, please open an issue or submit a pull request.

## License

This project is licensed under the [MIT License](LICENSE).
