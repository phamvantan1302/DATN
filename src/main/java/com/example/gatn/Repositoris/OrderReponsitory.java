package com.example.gatn.Repositoris;

import com.example.gatn.Entity.Client;
import com.example.gatn.Entity.Order;
import com.example.gatn.Entity.ProductDetail;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface OrderReponsitory extends JpaRepository<Order,Integer> {
    Order getOrderByClientAndStatus(Client client,Integer integer);

    List<Order> findAllByStatus(int status);

    Order getOrderById(Integer id);

    Page<Order> findByStatus(int status, Pageable pageable);

    @Query(value = "SELECT [id],[phone_number],[address],[use_name],[email],[item_discount],[total_money],[create_date]" +
            " FROM [dbo].[order]" +
            " WHERE id_client like CONCAT('%', :id, '%')" , nativeQuery = true)
    List<Order> getByClient(@Param("id") Integer id);

    @Query(value = "SELECT * FROM [dbo].[orderr] WHERE id_client LIKE CONCAT('%', :id, '%') ORDER BY create_date DESC", nativeQuery = true)
    Page<Order> getByClient1(@Param("id") Integer id,Pageable pageable);


}
