package com.exemple.rh.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmailService {

    @Autowired
    private JavaMailSender javaMailSender;

    @Async
    public void envoyerEmail(List<String> destinataires, String sujet, String contenu) {
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(destinataires.toArray(new String[0]));
            message.setSubject(sujet);
            message.setText(contenu);
            javaMailSender.send(message);
        } catch (Exception e) {
            // Log the error without blocking the main thread
            System.err.println("[EmailService] Failed to send email: " + e.getMessage());
        }
    }
}
