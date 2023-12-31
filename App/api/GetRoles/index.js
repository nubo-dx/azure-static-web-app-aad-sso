const fetch = require("node-fetch").default;

// add role names to this object to map them to group ids in your AAD tenant
// role name should be maximum 25 characters
const roleGroupMappings = {
  administrator: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  user: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
};

module.exports = async function (context, req) {
  const user = req.body || {};
  const roles = [];
  const groupsIdsOfUser = await getUserGroups(user.accessToken);

  for (const [role, groupId] of Object.entries(roleGroupMappings)) {
    if (groupsIdsOfUser.includes(groupId)) {
      roles.push(role);
    }
  }

  context.res.json({
    roles,
  });
};

async function getUserGroups(bearerToken) {
  const url = new URL("https://graph.microsoft.com/v1.0/me/memberOf");
  const response = await fetch(url, {
    method: "GET",
    headers: {
      Authorization: `Bearer ${bearerToken}`,
    },
  });

  if (response.status !== 200) {
    return [];
  }

  const graphResponse = await response.json();
  const ids = graphResponse.value.map((item) => item.id);
  return ids;
}
