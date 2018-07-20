//
//  Utils.c
//  Flat Land Server
//
//  Created by Zackory Cramer on 7/18/18.
//  Copyright © 2018 Zackory Cui. All rights reserved.
//

#include "Utils.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct PlayerInitPacket* getPacket(){
    int32_t i = 0x1fff0000;
    struct PlayerInitPacket *pack = malloc(sizeof(struct PlayerInitPacket));
    pack->id = i;
    return pack;
}

struct PlayerInitPacket* getInitPacket(char* name, int8_t id, int8_t config){
    struct PlayerInitPacket *pack = malloc(sizeof(struct PlayerInitPacket));
    pack->opcode = 0;
    pack->id = id;
    pack->config = config;
    strcpy((pack->name), name);
    return pack;
}

char* getPlayerName(struct PlayerInitPacket *packet){
    return packet->name;
}

int32_t getPlayerId(struct PlayerInitPacket *packet){
    return packet->id;
}
