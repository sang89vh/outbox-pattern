package com.sohan.student.dto;

import com.sohan.student.dao.entities.StudentEntity;
import javax.annotation.Generated;
import org.springframework.stereotype.Component;

@Generated(
    value = "org.mapstruct.ap.MappingProcessor",
    date = "2022-06-24T17:11:30+0700",
    comments = "version: 1.3.0.Final, compiler: javac, environment: Java 1.8.0_312 (Private Build)"
)
@Component
public class StudentMapperImpl implements StudentMapper {

    @Override
    public StudentDTO studentEntityToDTO(StudentEntity studentEntity) {
        if ( studentEntity == null ) {
            return null;
        }

        StudentDTO studentDTO = new StudentDTO();

        studentDTO.setStudentId( studentEntity.getStudentId() );
        studentDTO.setName( studentEntity.getName() );
        studentDTO.setEmail( studentEntity.getEmail() );
        studentDTO.setAddress( studentEntity.getAddress() );

        return studentDTO;
    }

    @Override
    public StudentEntity studentDTOToEntity(EnrollStudentDTO dto) {
        if ( dto == null ) {
            return null;
        }

        StudentEntity studentEntity = new StudentEntity();

        studentEntity.setName( dto.getName() );
        studentEntity.setEmail( dto.getEmail() );
        studentEntity.setAddress( dto.getAddress() );

        return studentEntity;
    }
}
