package org.example.devsync.repositories.interfaces;

import org.example.devsync.models.Tag;

import java.util.List;
import java.util.Optional;

public interface TagRepository {
    void save(Tag tag);
    Optional<Tag> findById(Long id);
    List<Tag> findAll();
    void update(Tag tag);
    void delete(Tag tag);
    Optional<Tag> findByName(String name);
}
