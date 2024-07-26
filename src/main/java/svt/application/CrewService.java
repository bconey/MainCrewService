/*******************************************************************************
 * Copyright (c) 2020, 2022 IBM Corporation and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License 2.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-2.0/
 *
 * SPDX-License-Identifier: EPL-2.0
 *******************************************************************************/
package svt.application;

import java.util.Set;
import java.io.StringWriter;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.json.JsonArray;
import jakarta.json.JsonArrayBuilder;
import jakarta.json.Json;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import jakarta.validation.Validator;
import jakarta.validation.ConstraintViolation;
import com.mongodb.client.FindIterable;
import org.bson.Document;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.eclipse.microprofile.openapi.annotations.Operation;
import org.eclipse.microprofile.openapi.annotations.responses.APIResponse;
import org.eclipse.microprofile.openapi.annotations.responses.APIResponses;

@Path("/crew")
@ApplicationScoped
public class CrewService {

    @Inject MongoDatabase db;
    @Inject Validator validator;
    private JsonArray getViolations(CrewMember crewMember) {
        Set<ConstraintViolation<CrewMember>> violations = validator.validate(
                crewMember);

        JsonArrayBuilder messages = Json.createArrayBuilder();

        for (ConstraintViolation<CrewMember> v : violations) {
            messages.add(v.getMessage());
        }

        return messages.build();
    }

    @GET
    @Path("/")
    @Produces(MediaType.APPLICATION_JSON)
    @APIResponses({
        @APIResponse(responseCode = "200", description = "Successfully listed the crew members."),
        @APIResponse(responseCode = "500", description = "Failed to list the crew members.") })
    @Operation(summary = "List the crew members from the database.")
    public Response retrieve() {
        StringWriter sb = new StringWriter();

        try {
            MongoCollection<Document> crew = db.getCollection("Crew");
            sb.append("[");
            boolean first = true;
            FindIterable<Document> docs = crew.find();
            for (Document d : docs) {
                if (!first) {
                    sb.append(",");
                } else {
                    first = false;
                }
                sb.append(d.toJson());
            }
            sb.append("]");
        } catch (Exception e) {
            e.printStackTrace(System.out);
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR).entity("[\"Unable to list crew members!\"]").build();
        }

        return Response.status(Response.Status.OK).entity(sb.toString()).build();
    }

}
