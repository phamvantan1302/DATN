package com.example.gatn.Service.Impl;

import com.example.gatn.Entity.Client;
import com.example.gatn.Repositoris.ClientReponsitory;
import com.example.gatn.Service.ClientService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ClientImpl implements ClientService {
    @Autowired
    private ClientReponsitory clientReponsitory;
    @Override
    public List<Client> listclient() {
        return clientReponsitory.findAll();
    }
}
