# global singleton script for managing, storing, and retreiving data files
# warning-ignore-all:return_value_discarded
extends Node




# -----
# dictionary for storing user-inputs
# variable is encrypted and stored to "\AppData\Roaming\Missouri Proud"
var user = {
        "filters": {
                "search": "", # string in the search bar
                "region": null, # the region selected (null = All Missouri)
                "saves": [], # the tourist destinations saved
                "outdoors": false, # state of the outdoors filter button
                "historical": false, # state of the historical filter button
                "attractions": false, # state of the attractions filter button
                "entertainment": false, # state of the entertainment filter button
                "food": false, # state of the food filter button
        },
        "card_id":{
                "explore_id": 0, # the tourist destination currently displayed on the right-hand side of the explore page
                "save_id": null, # the tourist destination currently displayed on the save page
                "quiz_question_id": null, # the current quiz question
                "quiz_result_id": null, # the tourist destination currently displayed on the quiz page results
        },
        "quiz_results": {
                "quiz_answers": { # the letter-form answer associated with its question number
                1: null,
                2: null,
                3: null,
                4: null,
                5: null,
                6: null,
                7: null,
                8: null,
                9: null,
                10: null,
                },
                "quiz_cards": null # the list of tourist destinations recommended
        },
}




# complete list of all tourism destinations and properties
var database = {
        "id_list": [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99],
        
        "nw_list": [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19],
        "ne_list": [20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39],
        "ce_list": [40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59],
        "sw_list": [60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79],
        "se_list": [80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99],
        
        "outdoors_list": [0,1,2,3,8,9,20,21,22,23,29,31,32,40,41,42,43,48,51,53,54,55,60,61,62,63,67,68,72,73,75,80,81,82,83,85,88,89,93,94,95],
        "historical_list": [1,2,4,5,6,7,10,24,25,26,27,28,30,31,34,43,44,45,46,47,48,49,51,64,65,66,67,71,84,85,86,87,89,91],
        "attractions_list": [4,8,9,10,11,28,29,30,31,40,48,49,50,51,68,69,70,71,88,89,90,91],
        "entertainment_list": [0,8,9,10,11,12,13,14,15,20,25,26,27,29,31,32,33,34,35,50,52,53,54,55,60,61,64,68,69,70,72,73,74,75,90,92,93,94,95],
        "food_list": [3,16,17,18,19,36,37,38,39,56,57,58,59,76,77,78,79,92,96,97,98,99],
        
        0: {
                "name": "Kansas City Zoo",
                "region": "NW Missouri",
                "tags": ["Outdoors", "Entertainment"],
                "summary_text": "The Kansas City Zoo is always a new journey, boasting one of the top animal exhibits in the United States. The zoo hosts more than 1,700 animals from across the globe, penguins, polar bears, orangutans, chimpanzees, stingrays --- you name it!!",
                "amenity_info": "Open Year-round\nATM Available\nSouvenir Shop\nRestaurant On-site\nWi-Fi Available",
                "contact_info": "Phone #\n816-595-1234",
                "disability_info": "ADA Fully Compliant",
                "age_info": "All Ages",
                "link": "https://www.kansascityzoo.org/"
                },
        1: {
                "name": "Fort Osage National Historic Landmark",
                "region": "NW Missouri",
                "tags": ["Outdoors", "Historical"],
                "summary_text": "A historical monument from the olden days, when Missouri was the \"wild west!\" Overlooking the Missouri River, William Clark from the Lewis & Clark expedition built the fort in 1808. Today the fort has been reconstructed and filled with historical actors to portray the experience to another generation.",
                "amenity_info": "Open Year-round\nSouvenir Shop\nOn The National Register Of Historic Places",
                "contact_info": "Phone #\n816-650-3278",
                "disability_info": "Partially Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "https://www.makeyourdayhere.com/Events-Attractions/Historic-Sites/Fort-Osage"
                },
        2: {
                "name": "Missouri Town 1855",
                "region": "NW Missouri",
                "tags": ["Outdoors", "Historical"],
                "summary_text": "A beautiful, scenic portrayal of village life from the 1800s. Historical actors and buildings create a living museum for visitors of all ages to experience.",
                "amenity_info": "Open Year-round\nSouvenir Shop",
                "contact_info": "Phone #\n816-229-8980",
                "disability_info": "Partially Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "https://www.makeyourdayhere.com/Events-Attractions/Historic-Sites/Missouri-Town-1855"
                },
        3: {
                "name": "City Market - Kansas City",
                "region": "NW Missouri",
                "tags": ["Outdoors", "Food"],
                "summary_text": "A daily blend of dining, shopping, and enjoyment,  the City Market delivers an assortment of fresh produce, meats, specialty groceries, flowers, and items from nearby farms. With a 150 year history of connecting consumers and producers directly, the City Market has become a home to many festivals.",
                "amenity_info": "Open Year-round\nATM Available\nSouvenir Shop\nRestaurant On-site\nWi-Fi Available\nOn The National Register Of Historic Places",
                "contact_info": "Phone #\n816-842-1271",
                "disability_info": "Partially Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "https://thecitymarketkc.org/"
                },
        4: {
                "name": "National WWI Museum and Memorial KC",
                "region": "NW Missouri",
                "tags": ["Historical", "Attraction"],
                "summary_text": "America's pioneer institution in remembrance of World War One and its lasting influence on global society. The museum maintains the most extensive collection of World War One memorabilia to guide visitors through the age of the Great War and inspire new conversations.",
                "amenity_info": "Open Year-round\nATM Available\nSouvenir Shop\nRestaurant On-site\nWi-Fi Available\nOn The National Register Of Historic Places",
                "contact_info": "Phone #\n816-888-8100",
                "disability_info": "ADA Fully Compliant\nPartially Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "https://www.theworldwar.org/"
                },
        5: {
                "name": "The Nelson-Atkins Museum of Art",
                "region": "NW Missouri",
                "tags": ["Historical"],
                "summary_text": "With more than 40,000 artworks, The Nelson-Atkins Museum is respected internationally as one of the prodigious general art museums in the United States. Its collection spans the globe with diverse multi-cultural origins, ranging from African, American, and contemporary to Chinese, European, and Japanese.",
                "amenity_info": "Open Year-round",
                "contact_info": "Phone #\n816-751-1278",
                "disability_info": "ADA Fully Compliant\nWheelchair Accessible",
                "age_info": "All Ages",
                "link": "https://www.nelson-atkins.org/"
                },
        6: {
                "name": "Harry S. Truman Library and Museum",
                "region": "NW Missouri",
                "tags": ["Historical"],
                "summary_text": "A monument to the legacy of America's 33rd President: Harry S. Truman. In his two presidential terms, he led America through the end of World War Two and the beginning of the Cold War. Today, millions of people have visited the library/museum in his honor.",
                "amenity_info": "Open Year-round\nSouvenir Shop",
                "contact_info": "Phone #\n816-268-8200",
                "disability_info": "Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "https://www.trumanlibrary.gov/"
                },
        7: {
                "name": "Negro Leagues Baseball Museum",
                "region": "NW Missouri",
                "tags": ["Historical"],
                "summary_text": "A multimedia exhibit capturing the history and heroes of the Negro leagues, from its inception to the 1960s. Hundreds of photographs, historical documents, and artifacts guide visitors through baseball's past.",
                "amenity_info": "Open Year-round",
                "contact_info": "Phone #\n888-221-1920",
                "disability_info": "Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "https://www.nlbm.com/"
                },
        8: {
                "name": "Arrowhead Stadium",
                "region": "NW Missouri",
                "tags": ["Outdoors", "Attractions", "Entertainment"],
                "summary_text": "Home to the winners of Super Bowl LIV, The Kansas City Cheifs, Missouri's premier sports team and stadium.",
                "amenity_info": "Open Year-round",
                "contact_info": "Phone #\n816- 920-9300",
                "disability_info": "ADA Fully Compliant\nWheelchair Accessible\nBraille Signage",
                "age_info": "All Ages",
                "link": "https://www.chiefs.com/stadium/"
                },
        9: {
                "name": "Kansas City Royals Kauffman Stadium",
                "region": "NW Missouri",
                "tags": ["Outdoors", "Attractions", "Entertainment"],
                "summary_text": "Home to the 2015 World Series Champion Kansas City Royals! Kauffman Stadium boasts one of the best stadiums in the major leagues, along with an expanded outfield plaza, hall of fame, and sports bar.",
                "amenity_info": "Open Year-round",
                "contact_info": "Phone #\n816-504-4040",
                "disability_info": "Partially Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "https://www.mlb.com/royals/ballpark"
                },
        10: {
                "name": "Union Station Kansas City",
                "region": "NW Missouri",
                "tags": ["Historical", "Attractions", "Entertainment"],
                "summary_text": "Reopened in 1999, Union Station is a 100-year-old historical landmark of the Kansas City area. The acclaimed Science City, planetarium, and extreme screen theatre are all found within its walls.",
                "amenity_info": "Open Year-round\nATM Available\nSouvenir Shop\nRestaurant On-site\nWi-Fi Available\nOn The National Register Of Historic Places",
                "contact_info": "Phone #\n816-460-2020",
                "disability_info": "ADA Fully Compliant\nWheelchair Accessible",
                "age_info": "All Ages",
                "link": "https://unionstation.org/"
                },
        11: {
                "name": "Kauffman Center for the Performing Arts",
                "region": "NW Missouri",
                "tags": ["Attractions", "Entertainment"],
                "summary_text": "A state-of-the-art facility comprised of The Muriel Kauffman Theatre and the Helzberg Hall. With more than 3,400 seats in total, Kauffman Center is a mega-modern arts center, which hosts Broadway companies, orchestras, and performance troupes on its stages.",
                "amenity_info": "Open Year-round",
                "contact_info": "Phone #\n816-994-7200",
                "disability_info": "ADA Fully Compliant",
                "age_info": "All Ages",
                "link": "https://www.kauffmancenter.org/"
                },
        12: {
                "name": "Breakout KC",
                "region": "NW Missouri",
                "tags": ["Entertainment"],
                "summary_text": "An entertainment, puzzle game in downtown Kansas City, with a very simple premise, break out of a room in an hour and you WIN! Find clues and crack cryptic riddles to find the way out!",
                "amenity_info": "Open Year-round",
                "contact_info": "Phone #\n816-945-2633",
                "disability_info": "Wheelchair Accessible",
                "age_info": "15+ Years Old ",
                "link": "https://breakoutkc.com/"
                },
        13: {
                "name": "Worlds of Fun",
                "region": "NW Missouri",
                "tags": ["Entertainment"],
                "summary_text": "The 235-acre, seven world-class roller coasters amusement park in Kansas City's backyard. The park features over 100 family rides, thrill rides, waterslides, and attractions.",
                "amenity_info": "Open Seasonally Only\nATM Available\nSouvenir Shop\nRestaurant On-site\nWi-Fi Available",
                "contact_info": "Phone #\n816-454-4545",
                "disability_info": "ADA Fully Compliant",
                "age_info": "All Ages",
                "link": "https://www.worldsoffun.com/"
                },
        14: {
                "name": "Legoland Discovery Center",
                "region": "NW Missouri",
                "tags": ["Entertainment"],
                "summary_text": "Legoland offers a fun, highly interactive, and educational 2-3 hour indoor experience, ideal for families with children ages 3-10. Legoland provides a range of interactive play areas.",
                "amenity_info": "Open Year-round",
                "contact_info": "Phone #\n816-471-4386",
                "disability_info": "Wheelchair Accessible",
                "age_info": "3-10 Years Old",
                "link": "https://www.legolanddiscoverycenter.com/kansas-city/"
                },
        15: {
                "name": "Sea Life Kansas City Aquarium",
                "region": "NW Missouri",
                "tags": ["Entertainment"],
                "summary_text": "With more than 5,000 sea creatures in 30 spectacular displays for a total of 260,000 gallons of water, The Sea Life Kansas City Aquarium pulls you into an astonishing world undersea.",
                "amenity_info": "Open Year-round\nSouvenir Shop\nRestaurant On-site",
                "contact_info": "Phone #\n816-471-4386",
                "disability_info": "ADA Fully Compliant",
                "age_info": "All Ages",
                "link": "https://www.visitsealife.com/kansas-city"
                },
        16: {
                "name": "Jack Stack Barbecue",
                "region": "NW Missouri",
                "tags": ["Food"],
                "summary_text": "With award-winning barbecue and beautiful interior, Jack Stack serves quality hickory-smoked meats, fresh seafood, and sides.",
                "amenity_info": "Open Year-round",
                "contact_info": "Phone #\n816-472-7427",
                "disability_info": "Partially Wheelchair Accessible\nBraille Signage",
                "age_info": "All Ages",
                "link": "https://www.jackstackbbq.com/"
                },
        17: {
                "name": "Arthur Bryant's Barbeque",
                "region": "NW Missouri",
                "tags": ["Food"],
                "summary_text": "One of the most renowned barbecue restaurants in the world, Arthur Bryant's slow-smoked ribs, beef, ham, pork, chicken, and sausage create a legendary flavor and restaurant.",
                "amenity_info": "Open Year-round",
                "contact_info": "Phone #\n816-231-1123",
                "disability_info": "ADA Fully Compliant",
                "age_info": "All Ages",
                "link": "https://www.arthurbryantsbbq.com/"
                },
        18: {
                "name": "Chaz on the Plaza",
                "region": "NW Missouri",
                "tags": ["Food"],
                "summary_text": "Located on the famed Country Club Plaza, Chaz is the signature restaurant of the historic Raphael Hotel that embodies the food, culture and spirit of Kansas City.",
                "amenity_info": "Open Year-roun\nATM Availabl\nWi-Fi Available\nOn The National Register Of Historic Places",
                "contact_info": "Phone #\n816-802-2152",
                "disability_info": "Not Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "https://www.raphaelkc.com/chazontheplaza"
                },
        19: {
                "name": "Boulevard Brewing Company",
                "region": "NW Missouri",
                "tags": ["Food"],
                "summary_text": "Founded in 1989, The Boulevard Brewing Company has become one of the largest specialty brewers in the Midwest. The Boulevard Brewing Company offers 45-minute tours of the brewery year-round.",
                "amenity_info": "Open Year-round\nSouvenir Shop",
                "contact_info": "Phone #\n816-474-7095",
                "disability_info": "ADA Fully Compliant\nPartially Wheelchair Accessible",
                "age_info": "21+ Years Old",
                "link": "https://www.boulevard.com/"
                },
        20: {
                "name": "Saint Louis Zoo",
                "region": "NE Missouri",
                "tags": ["Outdoors", "Entertainment"],
                "summary_text": "The Saint Louis Zoo devoted to connecting people to animals has 90-acres of the zoo and more than 12,000 animals. The zoo is world-renowned for its diverse collection of rare and endangered species.",
                "amenity_info": "Open Year-round",
                "contact_info": "Phone #\n314-781-0900",
                "disability_info": "ADA Fully Compliant",
                "age_info": "All Ages",
                "link": "https://www.stlzoo.org/"
                },
        21: {
                "name": "St. Louis Citygarden",
                "region": "NE Missouri",
                "tags": ["Outdoors"],
                "summary_text": "The Citygarden combines sculptures, plants, and fountains into a serene oasis in downtown St. Louis. The area offers a vibrant retreat from whatever ails you!",
                "amenity_info": "Open Year-round",
                "contact_info": "Phone #\n314-241-3337",
                "disability_info": "ADA Fully Compliant",
                "age_info": "All Ages",
                "link": "http://www.citygardenstl.org/"
                },
        22: {
                "name": "Grant’s Farm",
                "region": "NE Missouri",
                "tags": ["Outdoors"],
                "summary_text": "For more than five decades, the Busch family's 281-acre ancestral farm has delivered remarkable experiences to visitors. Founded and named by the 18th president Ulysses S. Grant, today, the farm holds over 900 animals from six continents of the world.",
                "amenity_info": "Open Seasonally Only\nATM Available\nSouvenir Shop\nRestaurant On-site",
                "contact_info": "Phone #\n314-843-1700",
                "disability_info": "Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "https://grantsfarm.com/"
                },
        23: {
                "name": "Meramec Caverns",
                "region": "NE Missouri",
                "tags": ["Outdoors"],
                "summary_text": "Since 1933, this seven-level underground natural wonder has delivered visitors with unforgettable tours down scenic, safe walkways.",
                "amenity_info": "Open Year-round\nSouvenir Shop\n",
                "contact_info": "Phone #\n573-468-3166",
                "disability_info": "Not Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "https://www.americascave.com/"
                },
        24: {
                "name": "Saint Louis Art Museum",
                "region": "NE Missouri",
                "tags": ["Historical"],
                "summary_text": "The Saint Louis Art Museum collects, presents, interprets, and conserves works of art of the highest quality across time and cultures. The museum aims to educate, inspire discovery, and elevate the human spirit.",
                "amenity_info": "Open Year-round\nSouvenir Shop\nRestaurant On-site\nWi-Fi Available",
                "contact_info": "Phone #\n314-721-0072",
                "disability_info": "ADA Fully Compliant\nWheelchair Accessible",
                "age_info": "All Ages",
                "link": "https://www.slam.org/"
                },
        25: {
                "name": "City Museum",
                "region": "NE Missouri",
                "tags": ["Historical", "Entertainment"],
                "summary_text": "In its 600,00 square foot enclosure, the City Museum offers MonstroCity, the world’s largest jungle gym, and 5-10 story spiral slides. The building, formerly owned by an international shoe company, today houses the Enchanted Caves, Everyday Circus, and the Cabin Inn.",
                "amenity_info": "Open Year-round\nATM Available\nSouvenir Shop\nRestaurant On-site",
                "contact_info": "Phone #\n314-231-2489",
                "disability_info": "Not Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "http://www.citymuseum.org/"
                },
        26:{
                "name": "The Saint Louis Science Center",
                "region": "NE Missouri",
                "tags": ["Historical", "Entertainment"],
                "summary_text": "As one of the top 10 science centers in the United States, the Saint Louis Science Center aims to ignite and sustain lifelong science and technology learning.",
                "amenity_info": "Open Year-round\nATM Available\nSouvenir Shop\nRestaurant On-site\nWi-Fi Available",
                "contact_info": "Phone #\n800-456-7572",
                "disability_info": "ADA Fully Compliant",
                "age_info": "All Ages",
                "link": "http://www.slsc.org/"
                },
        27: {
                "name": "The Magic House, St. Louis Children’s Museum",
                "region": "NE Missouri",
                "tags": ["Historical", "Entertainment"],
                "summary_text": "The Magic House engages all children in hands-on learning experiences that spark imagination, pique curiosity, enhance creativity, and develop problem-solving skills.",
                "amenity_info": "Open Year-round\nSouvenir Shop\nRestaurant On-site",
                "contact_info": "Phone #\n314-822-8900",
                "disability_info": "ADA Fully Compliant\nWheelchair Accessible",
                "age_info": "All Ages",
                "link": "http://www.magichouse.org/"
                },
        28: {
                "name": "The Gateway Arch",
                "region": "NE Missouri",
                "tags": ["Historical", "Attractions"],
                "summary_text": "From the thrilling views to the amazing stories, a visit to the Gateway Arch is an experience that never fails to inspire. Whether you have a few hours or a full day, you’ll find activities to please every member of your party. ",
                "amenity_info": "Open Year-round\nSouvenir Shop\nRestaurant On-site\nOn The National Register Of Historic Places",
                "contact_info": "Phone #\n877-982-1410",
                "disability_info": "Partially Wheelchair Accessible\nBraille Signage",
                "age_info": "All Ages",
                "link": "http://www.gatewayarch.com/"
                },
        29: {
                "name": "St. Louis Cardinals Busch Stadium",
                "region": "NE Missouri",
                "tags": ["Outdoor","Attractions", "Entertainment"],
                "summary_text": "Busch Stadium is home to the St. Louis Cardinals, a Major League Baseball team.",
                "amenity_info": "Open Year-round",
                "contact_info": "Phone #\n314-345-9565",
                "disability_info": "Partially Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "https://www.mlb.com/cardinals/ballpark/tours"
                },
        30: {
                "name": "The Cathedral Basilica of Saint Louis",
                "region": "NE Missouri",
                "tags": ["Historical","Attractions"],
                "summary_text": "The Cathedral is home to the largest collection of mosaic art in the western hemisphere, containing displays showing how mosaics are designed and applied. The museum contains numerous historic vestments and precious objects used in the various rites of the Church.",
                "amenity_info": "Open Year-round\nSouvenir Shop",
                "contact_info": "Phone #\n314-373-8241",
                "disability_info": "Partially Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "http://cathedralstl.org/"
                },
        31: {
                "name": "The Muny",
                "region": "NE Missouri",
                "tags": ["Outdoors", "Historical", "Attractions", "Entertainment"],
                "summary_text": "With nearly 11,000 seats, The Muny is America’s largest and oldest outdoor musical theater. The theater produces and presents exciting Broadway-style musicals every summer under the stars.",
                "amenity_info": "Open Seasonally Only\nSouvenir Shop\nShuttle Service Available",
                "contact_info": "Phone #\n314-361-1900",
                "disability_info": "ADA Fully Compliant\nPartially Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "http://www.muny.org/"
                },
        32: {
                "name": "Six Flags St. Louis",
                "region": "NE Missouri",
                "tags": ["Outdoors", "Entertainment"],
                "summary_text": "Six Flags St. Louis is a perfect getaway for family fun. With ten heart-pounding roller coasters, including three wooden and seven steel, Six Flags St. Louis is the Gateway to Thrills!",
                "amenity_info": "Open Seasonally Only",
                "contact_info": "Phone #\n636-938-5300",
                "disability_info": "Partially Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "http://www.sixflags.com/stlouis"
                },
        33: {
                "name": "Mastermind Room Escape",
                "region": "NE Missouri",
                "tags": ["Entertainment"],
                "summary_text": "Up to 12 people get “locked” in a room and try to “escape” the room by solving puzzles and uncovering clues to get out in 60 minutes or less.",
                "amenity_info": "Open Year-round",
                "contact_info": "Phone #\n314-690-3356",
                "disability_info": "Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "http://www.mastermindroomescape.com/"
                },
        34: {
                "name": "St. Louis Union Station",
                "region": "NE Missouri",
                "tags": ["Historical", "Entertainment"],
                "summary_text": "At Union Station, you can explore the fascinating St. Louis Aquarium, take a ride on the observation wheel, play mini-golf, and more!",
                "amenity_info": "Open Year-round",
                "contact_info": "Phone #\n314-621-5262",
                "disability_info": "Partially Wheelchair Accessible",
                "age_info": "All Ages",
                "link": ""
                },
        35: {
                "name": "Lumiere Place Casino",
                "region": "NE Missouri",
                "tags": ["Entertainment"],
                "summary_text": "With more than 1,700 slot machines, 60 table games, and a dedicated 13-table poker room, there’s something for every enthusiast at Lumière Place.",
                "amenity_info": "Open Year-round\nATM Available\nSouvenir Shop\nRestaurant On-site\nWi-Fi Available",
                "contact_info": "Phone #\n314-881-7777",
                "disability_info": "ADA Fully Compliant",
                "age_info": "21+ Years Old",
                "link": "http://www.lumiereplace.com/"
                },
        36: {
                "name": "Pappy’s Smokehouse",
                "region": "NE Missouri",
                "tags": ["Food"],
                "summary_text": "Pappy’s Smokehouse specializes in ribs, dry-rubbed and slow-smoked over apple and cherry wood. All meats are available by the pound, so you can chow down at home.",
                "amenity_info": "Open Year-round",
                "contact_info": "Phone #\n314-535-4340",
                "disability_info": "Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "http://www.pappyssmokehouse.com/"
                },
        37: {
                "name": "Budweiser Brewery Experience and The Biergarten",
                "region": "NE Missouri",
                "tags": ["Food"],
                "summary_text": "Visit the Home of Bud. Free tours take you through the brewing process at Budweiser. You will get to sample products during the tour and in The Biergarten.",
                "amenity_info": "Open Year-round\nATM Available\nSouvenir Shop",
                "contact_info": "Phone #\n314-577-2626",
                "disability_info": "ADA Fully Compliant",
                "age_info": "21+ Years Old",
                "link": "http://www.budweisertours.com/z01/index.php/st-louis/overview/"
                },
        38: {
                "name": "Crown Candy Kitchen",
                "region": "NE Missouri",
                "tags": ["Food"],
                "summary_text": "Crown Candy Kitchen is one of St Louis’ oldest and most popular attractions – known for its delicious hearty meals and homemade confectionary delights.",
                "amenity_info": "Open Year-round\nSouvenir Shop\nRestaurant On-site",
                "contact_info": "Phone #\n314-621-9650",
                "disability_info": "Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "https://crowncandykitchen.net/"
                },
        39: {
                "name": "Sugarfire Smoke House",
                "region": "NE Missouri",
                "tags": ["Food"],
                "summary_text": "The Sugarfire Smoke House is meant to be a different BBQ experience than all the others through the use of local ingredients and the awesome culinary exploits of the world-trained chefs and pitmasters.",
                "amenity_info": "Open Year-round",
                "contact_info": "Phone #\n314-997-2301",
                "disability_info": "Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "https://sugarfiresmokehouse.com/"
                },
        40: {
                "name": "The Lake of the Ozarks",
                "region": "CE Missouri",
                "tags": ["Outdoors", "Attractions"],
                "summary_text": "Missouri’s most popular lake destination features more than 1,100 miles of shoreline. The Lake of the Ozarks offers access to public beaches, great fishing, and plenty of room for fun and recreation on the water.",
                "amenity_info": "Open Year-round",
                "contact_info": "Phone #\n800-386-5253",
                "disability_info": "Partially Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "http://www.funlake.com/"
                },
        41: {
                "name": "Ozark Caverns",
                "region": "CE Missouri",
                "tags": ["Outdoors"],
                "summary_text": "Traditional tours and children’s tours are offered, exploring the great underground expanse. Find bats, salamanders, and interesting cave formations in this popular tourist destination.",
                "amenity_info": "Open Seasonally Only",
                "contact_info": "Phone #\n573-346-2500",
                "disability_info": "Partially Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "https://mostateparks.com/page/54199/cave-tours"
                },
        42: {
                "name": "Harry S Truman State Park",
                "region": "CE Missouri",
                "tags": ["Outdoors"],
                "summary_text": "Surrounded by water on three sides, the park encompasses the tip of a peninsula jutting into Truman Lake. The park offers a marina, camping, hiking, picnic sites, a shelter, swimming, boat rentals and ramps, and great fishing.",
                "amenity_info": "Open Year-round\nSouvenir Shop",
                "contact_info": "Phone #\n660-438-7711",
                "disability_info": "ADA Fully Compliant",
                "age_info": "All Ages",
                "link": "https://mostateparks.com/park/harry-s-truman-state-park"
                },
        43: {
                "name": "Trail of Tears Memorial",
                "region": "CE Missouri",
                "tags": ["Outdoors", "Historical"],
                "summary_text": "The Trail of Tears Memorial & Interpretive Walking Trail offer storyboards of life of the Cherokee Nation during the journey of 1838-39 along this one mile paved path.",
                "amenity_info": "Open Year-round",
                "contact_info": "Phone #\n573-774-6171",
                "disability_info": "ADA Fully Compliant\nPartially Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "https://www.visitpulaskicounty.org/"
                },
        44: {
                "name": "Missouri State Penitentiary",
                "region": "CE Missouri",
                "tags": ["Historical"],
                "summary_text": "The Missouri State Penitentiary (MSP) opened in 1836 along the banks of the Missouri River in Jefferson City, Missouri, the state capital. The prison housed inmates for 168 years and was the oldest continually operating prison west of the Mississippi until it was decommissioned in 2004.",
                "amenity_info": "Open Seasonally Only\nSouvenir Shop",
                "contact_info": "Phone #\n866-998-6998",
                "disability_info": "Not Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "http://www.missouripentours.com/"
                },
        45: {
                "name": "Auto World Museum",
                "region": "CE Missouri",
                "tags": ["Historical"],
                "summary_text": "This museum houses a wide variety of automobiles in historic settings. The museum displays nearly 80 vehicles from a large collection.",
                "amenity_info": "Open Seasonally Only\nSouvenir Shop\nWi-Fi Available",
                "contact_info": "Phone #\n573-642-2080",
                "disability_info": "Partially Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "http://www.autoworldmuseum.com/"
                },
        46: {
                "name": "National Churchill Museum",
                "region": "CE Missouri",
                "tags": ["Historical"],
                "summary_text": "The National Churchill Museum, through the imaginative and innovative use of technology, brings to life the story of Winston Churchill and the world he knew.",
                "amenity_info": "Open Year-round\nSouvenir Shop\nWi-Fi Available\nOn The National Register Of Historic Places",
                "contact_info": "Phone #\n573-592-5369",
                "disability_info": "Partially Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "http://www.nationalchurchillmuseum.org/"
                },
        47: {
                "name": "Missouri State Museum",
                "region": "CE Missouri",
                "tags": ["Historical"],
                "summary_text": "The exquisite exhibits cover Missouri’s history, from natural resources and westward expansion to famous Missourians and the Civil War in Missouri among other historic subjects.",
                "amenity_info": "Open Year-round\nSouvenir Shop",
                "contact_info": "Phone #\n573-751-2854",
                "disability_info": "Partially Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "https://mostateparks.com/park/missouri-state-museum"
                },
        48: {
                "name": "Historic Route 66",
                "region": "CE Missouri",
                "tags": ["Outdoors", "Historical", "Attractions"],
                "summary_text": "Explore the self-guided, scenic driving tour of old Route 66, between Exit 145 and Exit 169 of I-44.",
                "amenity_info": "Open Year-round\nSouvenir Shop",
                "contact_info": "Phone #\n877-858-8687",
                "disability_info": "Partially Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "http://www.visitpulaskicounty.org/"
                },
        49: {
                "name": "Missouri State Capitol",
                "region": "CE Missouri",
                "tags": ["Historical", "Attractions"],
                "summary_text": "The Capitol, completed in 1918, covers three acres in downtown Jefferson City. The building provides office space for the governor, lieutenant governor, secretary of state, treasurer, state auditor, and administrative agencies.",
                "amenity_info": "Open Year-round\nSouvenir Shop",
                "contact_info": "Phone #\n573-751-2854",
                "disability_info": "Partially Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "https://mostateparks.com/page/55179/capitol-tours"
                },
        50: {
                "name": "Governor’s Mansion",
                "region": "CE Missouri",
                "tags": ["Attractions"],
                "summary_text": "The mansion was constructed in 1871 as the official residence of Missouri’s First Family. Tour their home to see its beautiful architecture, the period furniture, and to learn the history of many of the state’s governors.",
                "amenity_info": "On The National Register Of Historic Places",
                "contact_info": "Phone #\n573-230-7000",
                "disability_info": "ADA Fully Compliant",
                "age_info": "All Ages",
                "link": "http://mansion.mo.gov/"
                },
        51: {
                "name": "Roubidoux Spring Cave",
                "region": "CE Missouri",
                "tags": ["Outdoors", "Historical", "Attractions"],
                "summary_text": "World-renowned cave scuba diving adventure in Laughlin Park. The average daily flow of the Roubidoux Spring is 37 million gallons; 16th largest in Missouri.",
                "amenity_info": "Open Year-round",
                "contact_info": "Phone #\n573-336-6355",
                "disability_info": "Not Wheelchair Accessible",
                "age_info": "18+ Years Old",
                "link": "https://visitpulaskicounty.org/"
                },
        52: {
                "name": "Margaritaville Lake Resort",
                "region": "CE Missouri",
                "tags": ["Entertainment"],
                "summary_text": "Margaritaville Lake Resort’s full-service marina features everything you need for fun and recreation on the water. Services include pontoon, boat rentals, water skis, parasailing, wakeboarding, and more!",
                "amenity_info": "Open Seasonally Only\nSouvenir Shop\nRestaurant On-site",
                "contact_info": "Phone #\n800-826-8272",
                "disability_info": "Partially Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "https://www.margaritavilleresortlakeoftheozarks.com/play/marina"
                },
        53: {
                "name": "Big Surf Waterpark",
                "region": "CE Missouri",
                "tags": ["Outdoors", "Entertainment"],
                "summary_text": "Big Surf offers a variety of fun activities. Experience three-story waterslides, a 600-foot-long lazy river, and “dry-land” games such as volleyball and basketball.",
                "amenity_info": "Open Seasonally Only",
                "contact_info": "Phone #\n573-346-6111",
                "disability_info": "Partially Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "http://www.bigsurfwaterpark.com/"
                },
        54: {
                "name": "Lucas Oil Speedway",
                "region": "CE Missouri",
                "tags": ["Outdoors", "Entertainment"],
                "summary_text": "Whether you’re a first-timer or a seasoned regular, Lucas Oil Speedway is the premier venue for watching exciting motorsports. Relax and refresh with great food, drinks, and concessions of all kinds, as well as additional amusements for kids of all ages!",
                "amenity_info": "Open Seasonally Only\nSouvenir Shop\nATM Available\nRestaurant On-site",
                "contact_info": "Phone #\n417-282-5984",
                "disability_info": "Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "http://www.bigsurfwaterpark.com/"
                },
        55: {
                "name": "Pirate’s Cove Adventure Golf",
                "region": "CE Missouri",
                "tags": ["Outdoors", "Entertainment"],
                "summary_text": "A spectacular golf experience through mountain caves, over footbridges, and beneath cascading waterfalls! Along the way, learn of legendary pirate exploits on two award-winning courses.",
                "amenity_info": "Open Seasonally Only",
                "contact_info": "Phone #\n417-282-5984",
                "disability_info": "Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "http://www.piratescove.net/locations/missouri/osage-beach"
                },
        56: {
                "name": "Madison’s Cafe",
                "region": "CE Missouri",
                "tags": ["Food"],
                "summary_text": "Madison’s offers fine American, Italian, and eclectic cuisine. Feast on hand-cut steaks, appetizers, soups, salads, seafood, sandwiches, pasta, desserts, a variety of distinctive and tantalizing, and unique signature dishes",
                "amenity_info": "Open Year-round\nWi-Fi Available",
                "contact_info": "Phone #\n573-634-2988",
                "disability_info": "Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "http://www.madisonscafe.com/"
                },
        57: {
                "name": "Shakespeare’s Pizza",
                "region": "CE Missouri",
                "tags": ["Food"],
                "summary_text": "Shakespeare's Pizza is a casual restaurant with a bar/lounge that specializes in pizza.",
                "amenity_info": "Open Year-round",
                "contact_info": "Phone #\n573-449-2454",
                "disability_info": "Partially Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "https://shakespeares.com/"
                },
        58: {
                "name": "Central Dairy Ice Cream Parlor",
                "region": "CE Missouri",
                "tags": ["Food"],
                "summary_text": "A Jefferson City tradition since the 1930s, Central Dairy serves legendary ice cream treats. The shop serves ice cream cones, dishes, sodas, malts, shakes, sundaes, and traditional favorites such as the banana split.",
                "amenity_info": "Open Year-round",
                "contact_info": "Phone #\n573-635-6148",
                "disability_info": "Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "https://centraldairy.biz/ice-cream-parlor/"
                },
        59: {
                "name": "Prison Brews",
                "region": "CE Missouri",
                "tags": ["Food"],
                "summary_text": "In this unique brewpub, near the Missouri State Penitentiary, there is a diverse food menu, with brick-oven pizza, burgers and sandwiches, steak, seafood, and other entrees.",
                "amenity_info": "Open Year-round",
                "contact_info": "Phone #\n573-635-0678",
                "disability_info": "Partially Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "http://www.prisonbrews.com/"
                },
        60: {
                "name": "Branson’s Promised Land Zoo",
                "region": "SW Missouri",
                "tags": ["Outdoors", "Entertainment"],
                "summary_text": "Branson’s top-rated animal attraction is located on 75 acres of natural Ozarks forest and fauna. The hands-on park allows you to get up close and personal with animals. ",
                "amenity_info": "Open Year-round\nSouvenir Shop\nRestaurant On-site\nShuttle Service Available",
                "contact_info": "Phone #\n417-337-9453",
                "disability_info": "Partially Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "http://www.plzoo.com/branson"
                },
        61: {
                "name": "Fantastic Caverns",
                "region": "SW Missouri",
                "tags": ["Outdoors", "Entertainment"],
                "summary_text": "America’s Ride-Thru Cave.  The  Jeep-drawn trams allow you to effortlessly experience the magnitude, the stillness, and the splendor of Fantastic Caverns while preserving its natural features.",
                "amenity_info": "Open Year-round\nSouvenir Shop\nWi-Fi Available",
                "contact_info": "Phone #\n417-833-2010",
                "disability_info": "Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "https://fantasticcaverns.com/"
                },
        62: {
                "name": "Lost Canyon Cave and Nature Trail",
                "region": "SW Missouri",
                "tags": ["Outdoors"],
                "summary_text": "Experience something unforgettable as you trek two-and-a-half miles on an electric cart along the Top of the Rock Lost Canyon Cave & Nature Trail. ",
                "amenity_info": "Open Year-round\nSouvenir Shop\nRestaurant On-site\nShuttle Service Available\nWi-Fi Available",
                "contact_info": "Phone #\n800-225-6343",
                "disability_info": "Not Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "https://bigcedar.com/activity/lost-canyon-cave-nature-trail/"
                },
        63: {
                "name": "Sequiota Park",
                "region": "SW Missouri",
                "tags": ["Outdoors"],
                "summary_text": "This 28-acre park includes a three-mile trail connected to the Springfield Conservation Nature Center, water features, and shelters.",
                "amenity_info": "Open Year-round",
                "contact_info": "Phone #\n417-864-1049",
                "disability_info": "Partially Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "http://www.parkboard.org/facilities/facility/details/sequiotapark-85"
                },
        64: {
                "name": "Pythian Castle",
                "region": "SW Missouri",
                "tags": ["Historical", "Entertainment"],
                "summary_text": "Built by the Knights of Pythias as an orphanage in 1913, today the castle serves for history tours, ghost tours, escape rooms, murder mystery dinners, and more!!",
                "amenity_info": "Open Year-round\nOn The National Register Of Historic Places",
                "contact_info": "Phone #\n417-865-1464",
                "disability_info": "Partially Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "https://pythiancastle.com/"
                },
        65: {
                "name": "George Washington Carver National Monument",
                "region": "SW Missouri",
                "tags": ["Historical"],
                "summary_text": "The George Washington Carver National Monument preserves the birthplace and legacy of the famed African American scientist, educator, and humanitarian.",
                "amenity_info": "Open Year-round\nSouvenir Shop\nOn The National Register Of Historic Places",
                "contact_info": "Phone #\n417-325-4151",
                "disability_info": "ADA Fully Compliant\nPartially Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "http://www.nps.gov/gwca"
                },
        66: {
                "name": "Veterans Memorial Museum",
                "region": "SW Missouri",
                "tags": ["Historical"],
                "summary_text": "The museum holds more than 2,000 exhibits honoring those who served in all branches of the U.S. military. Exhibits include sculptures, murals, historic artifacts, art, and thousands of memorabilia covering 20th Century conflicts.",
                "amenity_info": "Open Year-round\nSouvenir Shop\nShuttle Service Available",
                "contact_info": "Phone #\n417-325-4151",
                "disability_info": "ADA Fully Compliant",
                "age_info": "All Ages",
                "link": "http://www.veteransmemorialbranson.com/"
                },
        67: {
                "name": "Osage Village State Historic Site",
                "region": "SW Missouri",
                "tags": ["Outdoors", "Historical"],
                "summary_text": "This site was the location of a large, Osage Indian village between 1700 and 1775, when the Osage were first encountered by Europeans.",
                "amenity_info": "Open Year-round\nOn The National Register Of Historic Places",
                "contact_info": "Phone #\n417-682-2279",
                "disability_info": "Partially Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "https://mostateparks.com/park/osage-village-state-historic-site"
                },
        68: {
                "name": "Silver Dollar City",
                "region": "SW Missouri",
                "tags": ["Outdoors", "Attractions", "Entertainment"],
                "summary_text": "Silver Dollar City, an 1880s-style theme park in Branson, Missouri, has been internationally awarded for excellence. Today, Silver Dollar City encompasses more than 100 acres and draws about two million visitors each year with over 40 rides & attractions.",
                "amenity_info": "Open Seasonally Only\nSouvenir Shop\nSouvenir Shop\nRestaurant On-site\nATM Available\nShuttle Service Available\nWi-Fi Available",
                "contact_info": "Phone #\n800-831-4386",
                "disability_info": "ADA Fully Compliant\nWheelchair Accessible",
                "age_info": "All Ages",
                "link": "http://www.silverdollarcity.com/"
                },
        69: {
                "name": "Sight & Sound Theatres",
                "region": "SW Missouri",
                "tags": ["Attractions", "Entertainment"],
                "summary_text": "Sight & Sound Theatres combines art with sophisticated technology to bring stories from the Bible to life on stage. This inspiring family experience delivers original musical productions from a panoramic stage the length of a football field.",
                "amenity_info": "Open Year-round",
                "contact_info": "Phone #\n800-377-1277",
                "disability_info": "ADA Fully Compliant\nWheelchair Accessible",
                "age_info": "All Ages",
                "link": "https://www.sight-sound.com/"
                },
        70: {
                "name": "Wonders of Wildlife National Museum & Aquarium",
                "region": "SW Missouri",
                "tags": ["Attractions", "Entertainment"],
                "summary_text": "The aquarium consists of a 1.5-million-gallon aquarium adventure showcasing 35,000 live fish, mammals, reptiles, and birds, and immersive wildlife galleries.",
                "amenity_info": "Open Year-round\nSouvenir Shop\nRestaurant On-site\nWi-Fi Available",
                "contact_info": "Phone #\n888-222-6060",
                "disability_info": "Partially Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "http://www.wondersofwildlife.org/"
                },
        71: {
                "name": "Hollywood Wax Museum",
                "region": "SW Missouri",
                "tags": ["Historical","Attractions"],
                "summary_text": "The world-famous Hollywood Wax Museum offers a chance to get up close and personal with Hollywood stars for fun photos with props and poses!",
                "amenity_info": "Open Year-round\nSouvenir Shop",
                "contact_info": "Phone #\n417-337-8700",
                "disability_info": "ADA Fully Compliant\nWheelchair Accessible",
                "age_info": "All Ages",
                "link": "https://www.hollywoodwaxentertainment.com/branson-mo-attractions/hollywood-wax-museum/"
                },
        72: {
                "name": "Dolly Parton’s Stampede",
                "region": "SW Missouri",
                "tags": ["Outdoors","Entertainment"],
                "summary_text": "The Stampede’s 32 magnificent horses and cast of top-notch riders will thrill you with daring feats of trick riding and competition. Experience the Stampede of the Buffalo, hilarious racing pigs, fan-favorite competitions.",
                "amenity_info": "Open Seasonally Only\nSouvenir Shop\nATM Available\nWi-Fi Available",
                "contact_info": "Phone #\n417-336-3000",
                "disability_info": "ADA Fully Compliant\nWheelchair Accessible",
                "age_info": "All Ages",
                "link": "https://dpstampede.com/branson/show-schedule"
                },
        73: {
                "name": "The Haygoods",
                "region": "SW Missouri",
                "tags": ["Outdoors","Entertainment"],
                "summary_text": "This show features pop music, from the 1950s through today, along with country hits and acapella tunes. This talented group features energetic choreography and amazing performances on more than 20 different instruments.",
                "amenity_info": "Open Year-round",
                "contact_info": "Phone #\n417-332-2529",
                "disability_info": "Not Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "http://www.thehaygoods.com/"
                },
        74: {
                "name": "Pierce Arrow Theater",
                "region": "SW Missouri",
                "tags": ["Entertainment"],
                "summary_text": "Pierce-Arrow Theater is a family-friendly show that features clean comedy and a variety of music, including popular country, classic rock, Gospel favorites, and patriotic melodies.",
                "amenity_info": "Open Year-round",
                "contact_info": "Phone #\n417-336-8742",
                "disability_info": "ADA Fully Compliant",
                "age_info": "All Ages",
                "link": "http://www.piercearrowtheater.com/"
                },
        75: {
                "name": "The Branson Ferris Wheel",
                "region": "SW Missouri",
                "tags": ["Outdoors", "Entertainment"],
                "summary_text": "An iconic Ferris Wheel that has been ridden by nearly 17 million people. The Branson Ferris Wheel boasts spectacular views of the famed entertainment corridor and the picturesque Ozark Mountains.",
                "amenity_info": "Open Year-round",
                "contact_info": "Phone #\n417-334-1612",
                "disability_info": "Not Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "https://www.bransontracks.com/rides/ferris-wheel/"
                },
        76: {
                "name": "Grand Country Buffet",
                "region": "SW Missouri",
                "tags": ["Food"],
                "summary_text": "The Grand Country Buffet has more than 125 items to choose from. There is something for everyone, featuring meats, salads, soup, fruits, vegetables, bakery bread and desserts, an ice cream sundae bar, and more!",
                "amenity_info": "Open Year-round\nSouvenir Shop\nATM Available\nWi-Fi Available",
                "contact_info": "Phone #\n417-335-2434",
                "disability_info": "Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "http://www.grandcountry.com/restaurants"
                },
        77: {
                "name": "Mother’s Brewing Company",
                "region": "SW Missouri",
                "tags": ["Food"],
                "summary_text": "Mother’s Brewing Company offers tasting rooms to sample hand-crafted beers and seasonal selections.",
                "amenity_info": "Open Year-round\nSouvenir Shop",
                "contact_info": "Phone #\n417-862-0423",
                "disability_info": "Partially Wheelchair Accessible",
                "age_info": "21+ Years Old",
                "link": "http://www.mothersbrewing.com/"
                },
        78: {
                "name": "Danna’s Bar-B-Que and Burger Shop",
                "region": "SW Missouri",
                "tags": ["Food"],
                "summary_text": "Danna’s is known for its selection of fresh, never frozen, hamburgers, along with hickory-smoked pork, beer, chicken, ribs and sausage.",
                "amenity_info": "Open Year-round",
                "contact_info": "Phone #\n417-337-5527",
                "disability_info": "Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "http://www.dannasbbq.com/"
                },
        79: {
                "name": "Fall Creek Steak & Catfish House",
                "region": "SW Missouri",
                "tags": ["Food"],
                "summary_text": "Locally owned and operated, Fall Creek Steak & Catfish House is Branson’s Home of the Tossed Rolls! Watch for flying rolls. Catch and eat them while they’re hot!",
                "amenity_info": "Open Year-round\nSouvenir Shop",
                "contact_info": "Phone #\n417-336-5060",
                "disability_info": "ADA Fully Compliant\nPartially Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "http://fallcreeksteakhouse.com/"
                },
        80: {
                "name": "Elephant Rocks State Park",
                "region": "SE Missouri",
                "tags": ["Outdoors"],
                "summary_text": "At this park, giant, billion-year-old granite boulders stand end-to-end, like a train of red circus elephants. Spend some time reading the names and comments carved into the red granite by 19th century miners who worked in the area.",
                "amenity_info": "Open Year-round",
                "contact_info": "Phone #\n573-546-3454",
                "disability_info": "Braille Signage\nPartially Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "http://mostateparks.com/park/elephant-rocks-state-park"
                },
        81: {
                "name": "Onondaga Cave",
                "region": "SE Missouri",
                "tags": ["Outdoors"],
                "summary_text": "Onondaga Cave, a National Natural Landmark within Onondaga Cave State Park, is recognized as one of the most spectacular caves in the nation because of the quality of its formations. Tours lasts about an hour and 15 minutes, covering about 1 mile of passageways.",
                "amenity_info": "Open Seasonally Only\nSouvenir Shop",
                "contact_info": "Phone #\n573-245-6576",
                "disability_info": "Not Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "https://mostateparks.com/page/54234/cave-tours"
                },
        82: {
                "name": "Bonne Terre Mine",
                "region": "SE Missouri",
                "tags": ["Outdoors"],
                "summary_text": "One of the world’s largest man-made caverns, founded in 1860 as one of history’s earliest deep-earth lead mines. This was the world’s largest producer of lead ore until it was closed in 1962.",
                "amenity_info": "Open Year-round\nSouvenir Shop\nOn The National Register Of Historic Places",
                "contact_info": "Phone #\n888-843-3483",
                "disability_info": "Not Wheelchair Accessible",
                "age_info": "18+ Years Old",
                "link": "https://www.bonneterremine.com/"
                },
        83: {
                "name": "Echo Bluff State Park",
                "region": "SE Missouri",
                "tags": ["Outdoors"],
                "summary_text": "Echo Bluff State Park can fill your day with floating, hiking, swimming, fishing, or just relaxing in the shadow of the park’s namesake, Echo Bluff.",
                "amenity_info": "Open Year-round\nSouvenir Shop\nRestaurant On-site\nWi-Fi Available",
                "contact_info": "Phone #\n888-843-3483",
                "disability_info": "Not Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "https://mostateparks.com/park/echo-bluff-state-park"
                },
        84: {
                "name": "The Space Museum",
                "region": "SE Missouri",
                "tags": ["Historical"],
                "summary_text": "The Space Museum outlines the exciting history of humankind’s greatest adventure. The presentation and format of the exhibit are unique, with interactive displays providing a feel for what space exploration is like.",
                "amenity_info": "Open Year-round",
                "contact_info": "Phone #\n573-358-1200",
                "disability_info": "Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "http://www.space-mo.org/"
                },
        85: {
                "name": "Wall of Honor",
                "region": "SE Missouri",
                "tags": ["Outdoors", "Historical"],
                "summary_text": "Beautiful inscribed Wall of Honor at the entrance of Perryville City Park recognizing Perry County veterans of all wars.",
                "amenity_info": "Open Year-round",
                "contact_info": "Phone #\n573-358-1200",
                "disability_info": "Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "http://visitperrycounty.com/"
                },
        86: {
                "name": "Old St. Vincent’s Church",
                "region": "SE Missouri",
                "tags": ["Historical"],
                "summary_text": "Built-in 1853, Old St. Vincent’s Church is a beautifully restored Gothic Catholic Church of 15th century Italian Renaissance architecture. It is predominately gothic with some Roman influence in the arches.",
                "amenity_info": "Open Seasonally Only\nOn The National Register Of Historic Places",
                "contact_info": "Phone #\n573-335-1631",
                "disability_info": "ADA Fully Compliant",
                "age_info": "All Ages",
                "link": "http://www.oldstvincents.org/"
                },
        87: {
                "name": "National Shrine of Our Lady of the Miraculous Medal",
                "region": "SE Missouri",
                "tags": ["Historical"],
                "summary_text": "Saint Mary’s of the Barrens Historic District was founded in 1818 and the church was started in 1827. The Shrine was built in 1929 to honor Our Lady of the Miraculous Medal.",
                "amenity_info": "Open Year-round\nSouvenir Shop\nOn The National Register Of Historic Places",
                "contact_info": "Phone #\n573-768-7000",
                "disability_info": "ADA Fully Compliant\nWheelchair Accessible",
                "age_info": "All Ages",
                "link": "http://www.amm.org/MarysShrine/Visit%20the%20Shrine.aspx"
                },
        88: {
                "name": "Mississippi River Observation Deck",
                "region": "SE Missouri",
                "tags": ["Outdoors", "Attraction"],
                "summary_text": "Eight panoramic miles of the Mississippi River are visible from this 120-foot-long observation deck.",
                "amenity_info": "Open Year-round",
                "contact_info": "Phone #\n877-748-5300",
                "disability_info": "Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "https://www.visitmo.com/things-to-do/mississippi-river-observation-deck/"
                },
        89: {
                "name": "The Columns – Sikeston",
                "region": "SE Missouri",
                "tags": ["Outdoors","Historical", "Attraction"],
                "summary_text": "These six majestic pillars stand as a monument to the city’s religious heritage and the First Methodist Church, which was erected in 1879.",
                "amenity_info": "Open Year-round",
                "contact_info": "Phone #\n573-471-6362",
                "disability_info": "Partially Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "http://www.sikeston.net/"
                },
        90: {
                "name": "Ozark Actors Theatre",
                "region": "SE Missouri",
                "tags": ["Attraction", "Entertainment"],
                "summary_text": "Ozark Actors Theatre is one of only four professional theatres in out-state Missouri. The theatre exists to enhance cultural life through the presentation of professionally staged performing arts.",
                "amenity_info": "Open Year-round",
                "contact_info": "Phone #\n573-364-9523",
                "disability_info": "ADA Fully Compliant\nWheelchair Accessible",
                "age_info": "All Ages",
                "link": "http://www.ozarkactorstheatre.org/"
                },
        91: {
                "name": "Felix Valle House State",
                "region": "SE Missouri",
                "tags": ["Historical", "Attraction"],
                "summary_text": "This historic site includes three houses, the 1818 Federal-style Felix Vallé House, the 1792 Amoureux House, and the 1819 Shaw House. These are some of the finest examples of French colonial architecture in the nation.",
                "amenity_info": "Open Year-round\nOn The National Register Of Historic Places",
                "contact_info": "Phone #\n573-883-7102",
                "disability_info": "ADA Fully Compliant\nWheelchair Accessible",
                "age_info": "All Ages",
                "link": "http://mostateparks.com/park/felix-valle-house-state-historic-site"
                },
        92: {
                "name": "St. James Winery",
                "region": "SE Missouri",
                "tags": ["Entertainment", "Food"],
                "summary_text": "St. James Winery, which opened in 1970, is Missouri’s largest and most awarded wine producer.Visitors enjoy complimentary wine tastings, with more than 40 wines and juices to choose from.",
                "amenity_info": "Open Year-round\nSouvenir Shop\nWi-Fi Available",
                "contact_info": "Phone #\n800-280-9463",
                "disability_info": "ADA Fully Compliant\nWheelchair Accessible",
                "age_info": "21+ Years Old",
                "link": "http://www.stjameswinery.com/"
                },
        93: {
                "name": "SplashZone",
                "region": "SE Missouri",
                "tags": ["Outdoors", "Entertainment"],
                "summary_text": "Outdoor water park featuring heated water, a zero-depth entry, two water slides, a lazy river, a vortex and a sand play area.",
                "amenity_info": "Open Seasonally Only",
                "contact_info": "Phone #\n573-364-8222",
                "disability_info": "Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "https://www.rollamoparks.org/splashzone"
                },
        94: {
                "name": "Cape Splash Family Aquatic Center",
                "region": "SE Missouri",
                "tags": ["Outdoors", "Entertainment"],
                "summary_text": "Three and a half acres of water park fun can be found at Cape Splash Family Aquatic Center! The park includes a mat racer, a 259-foot long triple drop slide, a 700-foot lazy river, and more!",
                "amenity_info": "Open Seasonally Only",
                "contact_info": "Phone #\n573-339-6343",
                "disability_info": "ADA Fully Compliant",
                "age_info": "All Ages",
                "link": "https://www.cityofcapegirardeau.org/departments/parks___recreation/facilities/cape_splash_family_aquatic_center"
                },
        95: {
                "name": "Kokomo Joe’s Family Fun Center",
                "region": "SE Missouri",
                "tags": ["Outdoors", "Entertainment"],
                "summary_text": "Kokomo Joe’s has family fun for a variety of interests, from go-karts and mini-golf to batting cages, an arcade, and more!",
                "amenity_info": "Open Seasonally Only",
                "contact_info": "Phone #\n573-341-5656",
                "disability_info": "ADA Fully Compliant\nPartially Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "http://www.kokomojoesrolla.com/"
                },
        96: {
                "name": "Matt’s Steakhouse",
                "region": "SE Missouri",
                "tags": ["Food"],
                "summary_text": "Steak and seafood, in Rolla, MO, with a warm ambiance.",
                "amenity_info": "Open Year-round",
                "contact_info": "Phone #\n573-364-1220",
                "disability_info": "ADA Fully Compliant\nWheelchair Accessible",
                "age_info": "All Ages",
                "link": "http://www.mattssteakhouse.com/"
                },
        97: {
                "name": "Mary Jane Burgers & Brew",
                "region": "SE Missouri",
                "tags": ["Food"],
                "summary_text": "Choose from 20 craft beers and tap! Mary Jane was created to display a passion for fresh local ingredients prepared into delicious food.",
                "amenity_info": "Open Year-round\nSouvenir Shop\nWi-Fi Available",
                "contact_info": "Phone #\n573-547-6279",
                "disability_info": "ADA Fully Compliant\nWheelchair Accessible",
                "age_info": "21+ Years Old",
                "link": "http://maryjaneburgers.com/"
                },
        98: {
                "name": "A Slice of Pie",
                "region": "SE Missouri",
                "tags": ["Food"],
                "summary_text": "A Slice of Pie has about 30 different pies, cheesecakes, cakes, and no-sugar-added items ready at any time, and a list of about 50 it can make with a little notice.",
                "amenity_info": "Open Year-round",
                "contact_info": "Phone #\n573-364-6203",
                "disability_info": "Partially Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "http://www.asliceofpie.com/"
                },
        99: {
                "name": "Missouri Hick Bar B Que",
                "region": "SE Missouri",
                "tags": ["Food"],
                "summary_text": "Missouri Hick serves meats seasoned with a special rub and smoked for 12 hours. The food is king at Missouri Hick.",
                "amenity_info": "Open Year-round",
                "contact_info": "Phone #\n573-885-6791",
                "disability_info": "Partially Wheelchair Accessible",
                "age_info": "All Ages",
                "link": "http://missourihick.com/"
                },
}




# -----
# file path used to store and load user_data
var file_path = "user://encrypted_save.dat"




# Calls functions on application bootup
func _ready():
        connect_signals()
        load_data()




# saves the user dictionary to the encrypted_save file
func save_data():
        var file = File.new()
        var ERROR = file.open_encrypted_with_pass(file_path, File.WRITE, "FBLA2022") # Data is encrypted
        if ERROR == OK:
                file.store_var(user)
                file.close()
        else:
                print("ERROR")




# loads encrypted_save file and updates the user dictionary
func load_data():
        var file = File.new()
        if file.file_exists(file_path):
                var ERROR = file.open_encrypted_with_pass(file_path, File.READ, "FBLA2022") # Data is decrypted
                if ERROR == OK:
                        user = file.get_var()
                        file.close()
                else:
                        print("ERROR")




# upon a signal from SignalManger.gd update the users dictionary and save the new data
func update_filters(filter, state):
        if filter == "saves": # if-then sequence that saves the user's steps
                if state in user["filters"][filter]:
                        user["filters"][filter].erase(state)
                else:
                        user["filters"][filter].append(state)
        else:
                user["filters"][filter] = state
        save_data()
        SignalManager.emit_signal("queue_request")




# connects custom signals via SignalManager.gd
func connect_signals():
        SignalManager.connect("save_data_request", self , "save_data")
        
        SignalManager.connect("SearchFilter_signal", self, "update_filters")
        SignalManager.connect("RegionFilter_signal", self, "update_filters")
        SignalManager.connect("SaveFilter_signal", self, "update_filters")
        
        SignalManager.connect("OutdoorsFilter_signal", self, "update_filters")
        SignalManager.connect("HistoricalFilter_signal", self, "update_filters")
        SignalManager.connect("AttractionsFilter_signal", self, "update_filters")
        SignalManager.connect("EntertainmentFilter_signal", self, "update_filters")
        SignalManager.connect("FoodFilter_signal", self, "update_filters")




# -----