package org.example.repository.interfaces;

import org.example.model.entities.Request;
import org.example.model.enums.RequestStatus;

import java.util.List;
import java.util.Optional;

public interface RequestRepository {
    Request save(Request request);
    void update(Request request);
    Optional<Request> findById(Long id) ;
    void updateStatus(Long id, RequestStatus status);
    Optional<Request> findByTaskId(Long taskId);
    List<Request> findByUserId(Long userId);
}
