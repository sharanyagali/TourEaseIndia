CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    phone TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS destinations (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    state TEXT NOT NULL,
    best_season TEXT NOT NULL,
    description TEXT,
    route_info TEXT,
    map_embed_url TEXT,
    lat REAL,
    lng REAL
);

CREATE TABLE IF NOT EXISTS food (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    destination_id INTEGER NOT NULL,
    name TEXT NOT NULL,
    description TEXT,
    famous_for TEXT,
    image_url TEXT,
    FOREIGN KEY(destination_id) REFERENCES destinations(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS hotels (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    destination_id INTEGER NOT NULL,
    name TEXT NOT NULL,
    price_range TEXT NOT NULL,
    location TEXT,
    description TEXT,
    FOREIGN KEY(destination_id) REFERENCES destinations(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS packages (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    destination_id INTEGER NOT NULL,
    name TEXT NOT NULL,
    season TEXT NOT NULL,
    price INTEGER NOT NULL,
    duration TEXT NOT NULL,
    details TEXT,
    FOREIGN KEY(destination_id) REFERENCES destinations(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS bookings (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    package_id INTEGER NOT NULL,
    travellers INTEGER NOT NULL DEFAULT 1,
    status TEXT NOT NULL,
    booking_date DATETIME NOT NULL,
    FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY(package_id) REFERENCES packages(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS favorites (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    place_name TEXT NOT NULL,
    city TEXT,
    state TEXT NOT NULL,
    image_url TEXT,
    rating TEXT,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE,
    UNIQUE(user_id, place_name, state)
);

INSERT INTO destinations (name, state, best_season, description, route_info, map_embed_url, lat, lng) VALUES
('Goa Beaches', 'Goa', 'Winter', 'Famous for golden beaches, nightlife and water sports.', 'Reach Goa by flight to Dabolim Airport or trains to Madgaon / Thivim. Use local taxis or bikes to reach beaches.', 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1000000!2d73.8!3d15.3!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3bbfc4e4d4e3b4b3%3A0x64d6a2a3c6f9!2sGoa!5e0!3m2!1sen!2sin!4v0000000000000', 15.3000, 73.8000),
('Shimla Hills', 'Himachal Pradesh', 'Summer', 'Cool hill station with colonial architecture and Himalayan views.', 'Reach Shimla by toy train from Kalka, buses from Delhi / Chandigarh or cabs. Roads are hilly but scenic.', 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1000000!2d77.17!3d31.10!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x39057fdf2a3e5b7b%3A0x2ef2f1ce6e0d!2sShimla!5e0!3m2!1sen!2sin!4v0000000000000', 31.1000, 77.1700),
('Munnar Tea Gardens', 'Kerala', 'Monsoon', 'Green tea plantations, waterfalls and misty hills.', 'Reach Munnar by road from Kochi. Buses and cabs available. Roads are curvy but beautiful.', 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1000000!2d77.06!3d10.09!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3b07de6c4bb7bb7b%3A0x54a1e0b91c1e!2sMunnar!5e0!3m2!1sen!2sin!4v0000000000000', 10.0900, 77.0600),
('Hyderabad City', 'Telangana', 'Winter', 'City of pearls with Charminar, Golconda Fort and famous biryani.', 'Well connected by flights, trains and buses. Use metro, autos or app cabs within city.', 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3806.487945393208!2d78.4746!3d17.3850!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3bcb99f32d0f7af5%3A0xdeb86be7a5f14b16!2sCharminar!5e0!3m2!1sen!2sin!4v0000000000000', 17.3850, 78.4746),
('Delhi City', 'Delhi', 'Winter', 'Capital city with Red Fort, India Gate and street food.', 'All major transport modes available. Use metro network and e-rickshaws for local travel.', 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d224346.903883992!2d77.0689!3d28.5275!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x390ce2b4a7a9!2sNew%20Delhi!5e0!3m2!1sen!2sin!4v0000000000000', 28.5275, 77.0689);

INSERT INTO food (destination_id, name, description, famous_for, image_url) VALUES
(4, 'Hyderabadi Biryani', 'Aromatic basmati rice cooked with marinated meat and spices.', 'Iconic dish of Hyderabad', 'https://images.pexels.com/photos/960984/pexels-photo-960984.jpeg?auto=compress&cs=tinysrgb&w=800'),
(5, 'Chole Bhature', 'Spicy chickpeas curry served with deep-fried fluffy bread.', 'Famous North Indian breakfast', 'https://images.pexels.com/photos/1437267/pexels-photo-1437267.jpeg?auto=compress&cs=tinysrgb&w=800'),
(1, 'Goan Fish Curry', 'Tangy coconut-based curry made with fresh fish.', 'Popular coastal dish', 'https://images.pexels.com/photos/616354/pexels-photo-616354.jpeg?auto=compress&cs=tinysrgb&w=800'),
(2, 'Himachali Dham', 'Traditional festive meal served in temples and functions.', 'Authentic Himachali cuisine', ''),
(3, 'Kerala Appam & Stew', 'Soft hoppers served with coconut milk vegetable stew.', 'Comfort food of Kerala', '');

INSERT INTO hotels (destination_id, name, price_range, location, description) VALUES
(1, 'Sea Breeze Budget Stay', '1500-2500', 'Calangute Beach Road', 'Simple, clean rooms near the beach.'),
(2, 'Himalayan View Homestay', '1200-2000', 'Near Mall Road, Shimla', 'Family-run homestay with mountain view.'),
(3, 'Tea Valley Cottage', '1800-2800', 'Tea Estate Road, Munnar', 'Cottages surrounded by tea gardens.'),
(4, 'Old City Lodge', '1000-1800', 'Near Charminar, Hyderabad', 'Budget lodge close to major attractions.'),
(5, 'Capital Comfort Inn', '1800-2600', 'Karol Bagh, Delhi', 'Comfortable budget hotel in central Delhi.');

INSERT INTO packages (destination_id, name, season, price, duration, details) VALUES
(1, 'Goa Beach Escape', 'Winter', 8999, '3 Days / 2 Nights', 'Includes visit to Calangute, Baga and Fort Aguada with water sports options.'),
(2, 'Shimla Summer Retreat', 'Summer', 7999, '3 Days / 2 Nights', 'Includes Kufri, Mall Road, Jakhoo Temple and toy train ride (subject to availability).'),
(3, 'Munnar Monsoon Magic', 'Monsoon', 8499, '3 Days / 2 Nights', 'Covers tea gardens, Mattupetty Dam and Attukad waterfalls with scenic viewpoints.'),
(4, 'Hyderabad Heritage Tour', 'Winter', 5999, '2 Days / 1 Night', 'Covers Charminar, Golconda Fort and Hussain Sagar Lake with local food walk.'),
(5, 'Delhi Heritage & Food Trail', 'Winter', 6499, '2 Days / 1 Night', 'Visit Red Fort, India Gate and explore Chandni Chowk street food.');
