CREATE TABLE user (
    id BIGINT PRIMARY KEY AUTOINCREMENT,
    firstName VARCHAR(50) NULL DEFAULT NULL,
    lastName VARCHAR(50) NULL DEFAULT NULL,
    email VARCHAR(50) NULL, 
    psword VARCHAR(32) NOT NULL,
    admin TINYINT(1) NOT NULL DEFAULT 0,
    registeredAt DATETIME NOT NULL,
    lastLogin DATETIME NULL DEFAULT NULL
);

CREATE UNIQUE INDEX unique_id ON user(email);

CREATE TABLE order(
    id BIGINT PRIMARY KEY AUTOINCREMENT,
    userId BIGINT NOT NULL,
    sessionId VARCHAR(100) NOT NULL,
    token VARCHAR(100) NOT NULL,
    status SMALLINT(6) NOT NULL DEFAULT 0,
    subTotal FLOAT NOT NULL DEFAULT 0,
    itemDiscount FLOAT NOT NULL DEFAULT 0,
    tax FLOAT NOT NULL DEFAULT 0,
    shipping FLOAT NOT NULL DEFAULT 0,
    total FLOAT NOT NULL DEFAULT 0,
    promo VARCHAR(50) NULL DEFAULT NULL,
    discount FLOAT NOT NULL DEFAULT 0,
    grandTotal FLOAT NOT NULL DEFAULT 0,
    firstName VARCHAR(59) NULL DEFAULT NULL,
    lastName VARCHAR(50) NULL DEFAULT NULL,
    email VARCHAR(50) NULL,
    address VARCHAR(50) NULL DEFAULT NULL,
    zip VARCHAR(50) NULL DEFAULT NULL,
    city VARCHAR(50) NULL DEFAULT NULL,
    country VARCHAR(50) NULL DEFAULT NULL,
    createdAt DATETIME NOT NULL,
    updatedAt DATETIME NULL DEFAULT NULL,
    content TEXT NULL DEFAULT NULL,
    FOREIGN KEY(userId) REFERENCES user(id),
    FOREIGN KEY(email) REFERENCES user(email)
);

/*Product category eg. pants, skirts, etc*/
CREATE TABLE category (
    id BIGINT PRIMARY KEY AUTOINCREMENT,
    classification TEXT NOT NULL,
    metaTitle VARCHAR(100) NOT NULL,
    slug VARCHAR(100) NOT NULL,
    content TEXT NULL DEFAULT NULL,
    icon TEXT
);

/*Product section eg. women, men, Androgynous*/
CREATE TABLE section (
    id BIGINT PRIMARY KEY AUTOINCREMENT,
    classification TEXT NOT NULL,
    metaTitle VARCHAR(100) NOT NULL,
    slug VARCHAR(100) NOT NULL,
    content TEXT  NULL DEFAULT NULL,
    icon TEXT
);

CREATE TABLE product (
    id BIGINT PRIMARY KEY AUTOINCREMENT,
    productName VARCHAR(75) NOT NULL,
    slug VARCHAR(100) NOT NULL, /*for URL*/
    category BIGINT,
    section BIGINT,
    productNumber TEXT NOT NULL,
    price FLOAT NOT NULL DEFAULT 0,
    discount FLOAT NOT NULL DEFAULT 0,
    description TEXT,
    material TEXT,
    stockXS SMALLINT(6) NOT NULL DEFAULT 0,
    stockS SMALLINT(6) NOT NULL DEFAULT 0,
    stockM SMALLINT(6) NOT NULL DEFAULT 0,
    stockL SMALLINT(6) NOT NULL DEFAULT 0,
    stockXL SMALLINT(6) NOT NULL DEFAULT 0,
    stockOneSize SMALLINT(6) NOT NULL DEFAULT 0,
    shop TINYINT(1) NOT NULL DEFAULT 0,
    createdAt DATETIME NOT NULL,
    updatedAt DATETIME NULL DEFAULT NULL,
    postDate DATETIME NULL DEFAULT NULL,
    FOREIGN KEY (category) REFERENCES category(id),
    FOREIGN KEY (section) REFERENCES section(id)
);

CREATE TABLE order_items(
    id BIGINT PRIMARY KEY AUTOINCREMENT,
    productId BIGINT NOT NULL,
    orderId BIGINT NOT NULL,
    sku VARCHAR(100) NOT NULL,
    price FLOAT NOT NULL DEFAULT 0,
    discount FLOAT NOT NULL DEFAULT 0,
    quantity SMALLINT(6) NOT NULL DEFAULT 0,
    createdAt DATETIME NOT NULL,
    updatedAt DATETIME NULL DEFAULT NULL,
    content TEXT NULL DEFAULT NULL,
    FOREIGN KEY(productId) REFERENCES product(id),
    FOREIGN KEY(orderId) REFERENCES order(id)
)

CREATE TABLE transaction(
    id BIGINT PRIMARY KEY AUTOINCREMENT,
    cutomerId BIGINT NOT NULL,
    orderId BIGINT NOT NULL,
    code VARCHAR(100) NOT NULL,
    type SMALLINT(6) NOT NULL DEFAULT 0,
    mode SMALLINT(6) NOT NULL DEFAULT 0,
    status SMALLINT(6) NOT NULL DEFAULT 0,
    createdAt DATETIME NOT NULL,
    updatedAt DATETIME NULL DEFAULT NULL,
    content TEXT NULL DEFAULT NULL,
    FOREIGN KEY(userId) REFERENCES user(id),
    FOREIGN KEY(orderId) REFERENCES order(id)
)

CREATE TABLE product_meta (
    id BIGINT PRIMARY KEY AUTOINCREMENT,
    productId BIGINT NOT NULL,
    key VARCHAR(50) NOT NULL,
    content TEXT NULL DEFAULT NULL,
    FOREIGN KEY (productId) REFERENCES product(id)
);

CREATE UNIQUE INDEX unique_slug ON products(slug);

CREATE TABLE wishlist (
    id BIGINT PRIMARY KEY AUTOINCREMENT,
    userId BIGINT NOT NULL,
    productId BIGINT NOT NULL,
    FOREIGN KEY (userId) REFERENCES user(id),
    FOREIGN KEY (productId) REFERENCES products(pid)
);

CREATE TABLE product_review (
    id BIGINT PRIMARY KEY AUTOINCREMENT,
    productId BIGINT NOT NULL,
    userId BIGINT NOT NULL,
    userName TEXT,
    postDate DATETIME  NOT NULL,
    rating INTEGER NOT NULL CHECK (rating BETWEEN 1 AND 5),
    title TEXT NULL DEFAULT NULL,
    content TEXT NULL DEFAULT NULL,
    FOREIGN KEY(productId) REFERENCES product(id),
    FOREIGN KEY(userId) REFERENCES user(id)
);

CREATE TABLE cart (
    id BIGINT PRIMARY KEY AUTOINCREMENT,
    userId BIGINT NULL DEFAULT NULL,
    sessionId VARCHAR(100) NOT NULL,
    token VARCHAR(100) NOT NULL,
    status SMALLINT(6) NOT NULL DEFAULT 0,
    firstName VARCHAR(50) NULL DEFAULT NULL,
    lastName VARCHAR(50) NULL DEFAULT NULL,
    email VARCHAR(50) NULL,
    address VARCHAR(50) NULL DEFAULT NULL,
    zip VARCHAR(50) NULL DEFAULT NULL,
    city VARCHAR(50) NULL DEFAULT NULLL,
    country VARCHAR(50) NULL DEFAULT NULL,
    createdAt DATETIME NOT NULL,
    updatedAt DATETIME NULL DEFAULT NULL,
    content TEXT TEXT NULL DEFAULT NULL,
    FOREIGN KEY(userId) REFERENCES user(id)
);

CREATE TABLE cart_item (
    id BIGINT PRIMARY KEY AUTOINCREMENT,
    productId BIGINT NOT NULL,
    cartId BIGINT NOT NULL,
    sku VARCHAR(100) NOT NULL,
    price FLOAT NOT NULL DEFAULT 0,
    discount FLOAT NOT NULL DEFAULT 0,
    quantity SMALLINT(6) NOT NULL DEFAULT 0,
    active TINYINT(1) NOT NULL DEFAULT 0,
    createdAt DATETIME NOT NULL,
    updatedAt DATETIME NULL DEFAULT NULL,
    content TEXT NULL DEFAULT NULL,
    FOREIGN KEY(productId) REFERENCES product(pid),
    FOREIGN KEY(cartId) REFERENCES cart(id)

)

INSERT INTO user(email, psword, firstName, lastName) VALUES
("test@test.de", "test", "Max", "Musterman");

INSERT INTO wishlist(userId, productId) VALUES
(1, 1),
(1, 2),
(1, 6);

INSERT INTO category(classification ,icon) VALUES
("Dresses",""),
("Coats",""),
("Pants",""),
("Tops",""),
("Outwear",""),
("Skirts",""),
("Accesories","");

INSERT INTO section(classification, icon, content) VALUES
("Women","",""),
("Androgynous","",""),
("Men","","");