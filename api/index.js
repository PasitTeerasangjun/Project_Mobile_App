const express = require('express')
const app = express()
app.use(express.json());

const users = [
    {
        "id": 1,
        "firstName": "Terry",
        "lastName": "Medhurst",
        "phone": "+63 791 675 8914",
        "image": "https://robohash.org/Terry.png?set=set4", 
    },
    {
        "id": 2,
        "firstName": "Sheldon",
        "lastName": "Quigley",
        "phone": "+7 813 117 7139",
        "image": "https://robohash.org/Sheldon.png?set=set4",
    },
    {
        "id": 3,
        "firstName": "Terrill",
        "lastName": "Hills",
        "phone": "+63 739 292 7942",
        "image": "https://robohash.org/Terrill.png?set=set4",
    },
    {
        "id": 4,
        "firstName": "Miles",
        "lastName": "Cummerata",
        "phone": "+86 461 145 4186",
        "image": "https://robohash.org/Miles.png?set=set4",
    },
    {
        "id": 5,
        "firstName": "Mavis",
        "lastName": "Schultz",
        "phone": "+372 285 771 1911",
        "image": "https://robohash.org/Mavis.png?set=set4",
    },
    {
        "id": 6,
        "firstName": "Alison",
        "lastName": "Reichert",
        "phone": "+351 527 735 3642",
        "image": "https://robohash.org/Alison.png?set=set4",
    },
    {
        "id": 7,
        "firstName": "Oleta",
        "lastName": "Abbott",
        "phone": "+62 640 802 7111",
        "image": "https://robohash.org/Oleta.png?set=set4",
    },
    {
        "id": 8,
        "firstName": "Ewell",
        "lastName": "Mueller",
        "phone": "+86 946 297 2275",
        "image": "https://robohash.org/Ewell.png?set=set4",
    },
    {
        "id": 9,
        "firstName": "Demetrius",
        "lastName": "Corkery",
        "phone": "+86 356 590 9727",
        "image": "https://robohash.org/Demetrius.png?set=set4",
    },
    {
        "id": 10,
        "firstName": "Eleanora",
        "lastName": "Price",
        "phone": "+60 184 408 0824",
        "image": "https://robohash.org/Eleanora.png?set=set4",
    },
    {
        "id": 11,
        "firstName": "Marcel",
        "lastName": "Jones",
        "phone": "+967 253 210 0344",
        "image": "https://robohash.org/Marcel.png?set=set4",
    },
    {
        "id": 12,
        "firstName": "Assunta",
        "lastName": "Rath",
        "phone": "+380 962 542 6549",
        "image": "https://robohash.org/Assunta.png?set=set4",
    },
    {
        "id": 13,
        "firstName": "Trace",
        "lastName": "Douglas",
        "phone": "+1 609 937 3468",
        "image": "https://robohash.org/Trace.png?set=set4",
    },
    {
        "id": 14,
        "firstName": "Enoch",
        "lastName": "Lynch",
        "phone": "+94 912 100 5118",
        "image": "https://robohash.org/Enoch.png?set=set4",
    },
    {
        "id": 15,
        "firstName": "Jeanne",
        "lastName": "Halvorson",
        "phone": "+86 581 108 7855",
        "image": "https://robohash.org/Jeanne.png?set=set4",
    },


]

app.get('/user', function (_req, res) {
    if(users){
        res.status(200).send({
            users
        });
    }else{
        res.status(401).send('error');
    }
})

app.listen(3000)