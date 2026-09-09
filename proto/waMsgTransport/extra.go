package waMsgTransport

import (
	"github.com/iKonoTelecomunicaciones/whatsmeow/proto/armadilloutil"
	"github.com/iKonoTelecomunicaciones/whatsmeow/proto/instamadilloTransportPayload"
	"github.com/iKonoTelecomunicaciones/whatsmeow/proto/waMsgApplication"
)

const (
	FBMessageApplicationVersion = 2
	IGMessageApplicationVersion = 3
)

func (msg *MessageTransport_Payload) DecodeFB() (*waMsgApplication.MessageApplication, error) {
	return armadilloutil.Unmarshal(&waMsgApplication.MessageApplication{}, msg.GetApplicationPayload(), FBMessageApplicationVersion)
}

func (msg *MessageTransport_Payload) DecodeIG() (*instamadilloTransportPayload.TransportPayload, error) {
	return armadilloutil.Unmarshal(&instamadilloTransportPayload.TransportPayload{}, msg.GetApplicationPayload(), IGMessageApplicationVersion)
}
