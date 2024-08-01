db.createUser(
    {
        user: "blueskyuser",
        pwd: "sun",
        roles: [
            {
                role: "readWrite",
                db: "bluesky"
            }
        ]
    }
);
