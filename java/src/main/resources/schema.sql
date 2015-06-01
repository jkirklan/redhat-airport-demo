CREATE TABLE flight_status(
	id int NOT NULL AUTO_INCREMENT,
    status_type VARCHAR(16) NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE coupon(
	id int NOT NULL AUTO_INCREMENT,
    company VARCHAR(32) NOT NULL,
    company_code VARCHAR(6) NOT NULL,
    path VARCHAR(96),
    offer VARCHAR(32) NOT NULL,
    description VARCHAR(96),
    delay_severity int,
    status_id int NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(status_id) REFERENCES flight_status(id)
);