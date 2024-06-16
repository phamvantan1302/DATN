package com.example.gatn.Service;

import com.example.gatn.Entity.Image;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface ImageService {
    List<Image> getByIdSp(Integer idsp);
}
