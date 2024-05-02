CREATE TABLE data (
  id INT PRIMARY KEY AUTO_INCREMENT,
  key1 VARCHAR(255),
  key2 VARCHAR(255),
  value1 FLOAT,
  value2 FLOAT
);

CREATE TABLE key_vectors (
  id INT PRIMARY KEY AUTO_INCREMENT,
  data_id INT NOT NULL,
  key1 VARCHAR(255),
  key2 VARCHAR(255),
  FOREIGN KEY (data_id) REFERENCES data(id)
);

CREATE TABLE value_vectors (
  id INT PRIMARY KEY AUTO_INCREMENT,
  data_id INT NOT NULL,
  value1 FLOAT,
  value2 FLOAT,
  FOREIGN KEY (data_id) REFERENCES data(id)
);

CREATE TABLE processed_data (
  id INT PRIMARY KEY AUTO_INCREMENT,
  data_id INT NOT NULL,
  key1 VARCHAR(255),
  key2 VARCHAR(255),
  value1 FLOAT,
  value2 FLOAT,
  FOREIGN KEY (data_id) REFERENCES data(id)
);