const livekitApi = require("livekit-server-sdk");
const { con } = require("../config/DbConnection");
const AccessToken = livekitApi.AccessToken;
const RoomServiceClient = livekitApi.RoomServiceClient;

const API_KEY ='devkey' //'APIDtH7DcuYCwJz'
const SECRET = 'secret' //'oTiri02VAQvb9OCCaCnT3Nk7eU95TeH7tfStELUQExRA'
exports.generateAdminToken = (req, res) => {
  // if this room doesn't exist, it'll be automatically created when the first
  // client joins
  const roomName = req.params.room_id;
  // identifier to be used for participant.
  // it's available as LocalParticipant.identity with livekit-client SDK
  const participantName = "WVSUCC HRMO";

  const at = new AccessToken(API_KEY, SECRET, {
    identity: participantName,
  });
  at.addGrant({ roomJoin: true, room: roomName });

  const token = at.toJwt();

  res.send(token);
};

exports.generateUsersToken = (req, res) => {

  const roomName = req.params.room_id;

  const participantName = req.params.fullname;

  console.log('room:',roomName,"participant:",participantName)

  const at = new AccessToken(API_KEY, SECRET, {
    identity: participantName,
  });
  at.addGrant({ roomJoin: true, room: roomName });

  const token = at.toJwt();

  res.send(token);
};
